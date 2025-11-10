import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app_ui/common/widgets/service_card1.dart';
import 'package:salon_app_ui/utils/constants.dart';
import 'package:salon_app_ui/utils/custom_icons.dart';
import 'package:salon_app_ui/utils/tabbar_delegate.dart';

class StoreDetailScreen extends StatefulWidget {
  const StoreDetailScreen({super.key});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final TabController _tabController;

  final double bannerHeight = 250.h; //150.0;
  final double expandedHeight = 280.h; // banner height
  final double avatarMax = 90.0;
  bool _showToolbarTitle = false;

  final GlobalKey _nameKey = GlobalKey();
  final GlobalKey _flexibleSpaceKey = GlobalKey();

  final double expandedAppbar2Height = 280;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(_updateToolbarTitleVisibility);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _updateToolbarTitleVisibility() {
    print('its here 1');
    final ctx = _nameKey.currentContext;
    if (ctx == null) return;

    final rb = ctx.findRenderObject() as RenderBox?;
    if (rb == null || !rb.attached) return;
    print('its here 2');

    // Screen Y of the top of the large "John Doe" (in the Name+Bio section)
    final topDy = rb.localToGlobal(Offset.zero).dy;

    // The content area starts below the pinned toolbar (status bar + kToolbarHeight)
    final statusBar = MediaQuery.of(context).padding.top;
    final toolbarBottom = statusBar + kToolbarHeight;

    // Show toolbar title ONLY when the big "John Doe" is fully hidden under the toolbar
    // i.e., its bottom (top + height) is <= toolbar bottom.
    final nameBottom = topDy + rb.size.height;
    final shouldShow = nameBottom <= toolbarBottom + 1;

    if (shouldShow != _showToolbarTitle) {
      print("it is updating");

      setState(() => _showToolbarTitle = shouldShow);
    }
  }

  double _calculateExpandedHeight(
    BuildContext context,
    String? description,
    bool hasLinks,
  ) {
    // Constants
    double baseHeightWithoutDescription = 150;

    if (hasLinks) baseHeightWithoutDescription += 70;
    // Covers name, email, followers, join date, and social links
    // Adjust until it matches your layout’s fixed content
    const double horizontalPadding = 8;

    if (description == null || description.isEmpty) {
      return baseHeightWithoutDescription;
    }

    // Get available text width
    final screenWidth = MediaQuery.of(context).size.width;
    final textWidth = screenWidth - (horizontalPadding * 2);

    // Measure description height
    final textPainter = TextPainter(
      text: TextSpan(
        text: description,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          letterSpacing: 0.5,
          wordSpacing: 0.5,
          fontSize: 13,
        ),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: textWidth);

    final double descriptionHeight = textPainter.size.height;

    // Add description height to base height
    return baseHeightWithoutDescription + descriptionHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              clipBehavior: Clip.none,
              backgroundColor:
                  AppConstants.whiteColor, // AppConstants.greenColor,
              pinned: true,
              leadingWidth: 50,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 13,
                  backgroundColor: AppConstants.greyColor.withValues(
                    alpha: 0.5,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 18),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),

              // Toolbar title (appears only after Name+Bio "John Doe" is hidden)
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: _showToolbarTitle ? 1.0 : 0.0,

                child:
                    //  _showToolbarTitle
                    //     ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "AquaFix Plumbing",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppConstants.blackColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 16,
                            ),
                            Text(
                              "4.5",
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.blackColor,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "(123 Reviews)",
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.blackColor.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                // : Text(
                //     "Hairdresser",
                //     style: GoogleFonts.roboto(
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //       color: AppConstants.whiteColor,
                //       letterSpacing: 0.5,
                //     ),
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //   ),
              ),
              expandedHeight: expandedHeight,
              // toolbarHeight: 150,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  // final currentHeight = constraints
                  //     .biggest
                  //     .height; // between kToolbarHeight..expandedHeight

                  // // Collapse factor t: 1 = expanded, 0 = collapsed
                  // double t =
                  //     (currentHeight - kToolbarHeight) /
                  //     (expandedHeight - kToolbarHeight);
                  // t = t.clamp(0.0, 1.0);

                  // // Avatar shrinks 80 -> 0 and hides before overlapping toolbar
                  // final avatarSize = avatarMax * t;
                  // final showAvatar =
                  //     avatarSize > 1 &&
                  //     currentHeight >
                  //         (kToolbarHeight +
                  //             MediaQuery.of(context).padding.top +
                  //             8);

                  return FlexibleSpaceBar(
                    background: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Banner Image
                            Container(
                              height: bannerHeight,
                              width: double.infinity,
                              color: Colors.blueGrey[300],
                              child: Image.network(
                                "https://cdn.create.vista.com/api/media/small/168839808/stock-photo-tools",
                                // 'https://images.unsplash.com/photo-1503264116251-35a269479413',
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Profile image with edit icon
                            Positioned(
                              bottom: -avatarMax / 2,
                              left: 16,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: avatarMax, // avatarSize,
                                  height: avatarMax,
                                  // avatarSize,
                                  decoration: BoxDecoration(
                                    color: AppConstants.greyColor,
                                    //  isDarkMode
                                    //     ? AppConstants
                                    //         .lightNavyBlueColor
                                    //     : Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlLOTS-3wbiIK0i8Z4zp5fmk-6tp4GADhvMw&s",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                // CircleAvatar(
                                //   radius: avatarMax / 2,
                                //   backgroundColor: isDarkMode
                                //       ? AppConstants.lightNavyBlueColor
                                //       : Colors.white,
                                //   child: CircleAvatar(
                                //     radius: (profileImageSize - 4) / 2,
                                //     backgroundImage: user.imgUrl != null
                                //         ? NetworkImage(
                                //             user.imgUrl!,
                                //           )
                                //         : null,
                                //     backgroundColor:
                                //         AppConstants.lightGrayColor,
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: avatarMax / 2 + 8),
                      ],
                    ),
                  );
                },
              ),
            ),

            SliverAppBar(
              expandedHeight: 35.h,
              toolbarHeight: 35.h,
              backgroundColor: AppConstants.whiteColor,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
                  child: Row(
                    key: _flexibleSpaceKey,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "AquaFix Plumbing",
                                key: _nameKey,
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(width: 5),

                              Image.asset(
                                height: 15,
                                width: 15,
                                AppConstants.verifiedImg,
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 16,
                              ),
                              Text(
                                "4.5",
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppConstants.blackColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "(123 Reviews)",
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppConstants.blackColor.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppConstants.greyColor.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          CustomIcons.chat_empty,
                          color: AppConstants.greenColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppConstants.greenColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.call_outlined,
                          color: AppConstants.whiteColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Services",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.blackColor,
                      ),
                    ),
                    // Spacer(),
                    Row(
                      children: [
                        Text(
                          "View all",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppConstants.greenColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                          color: AppConstants.greenColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                // color: Colors.amber,
                height: 250.h, // MediaQuery.sizeOf(context).height * 0.25,
                width: MediaQuery.sizeOf(context).width,
                child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  controller: ScrollController(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 12.0,
                      ),
                      child: ServiceCard1(),
                    );
                  },
                ),
              ),
            ),

            SliverPersistentHeader(
              pinned: true,
              delegate: TabBarHeaderDelegate(
                TabBar(
                  controller: _tabController,
                  padding: EdgeInsets.all(8),
                  tabAlignment: TabAlignment.fill,
                  indicatorAnimation: TabIndicatorAnimation.elastic,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppConstants.greenColor,
                  // dividerColor: AppConstants.greenColor,
                  // dividerHeight: 3,
                  indicatorWeight: 4,
                  // labelColor: ,
                  indicatorPadding: EdgeInsetsGeometry.only(top: 8),
                  labelPadding: EdgeInsets.all(8),
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  dividerColor: Colors.transparent,
                  labelColor: AppConstants.blackColor,
                  unselectedLabelColor: AppConstants.blackColor.withValues(
                    alpha: 0.5,
                  ),
                  tabs: [
                    Text(
                      "About Us",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Location",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Store Reviews",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                isDarkMode: false,
              ),
            ),

            // Current tab’s content as slivers (single unified scroll)
            ..._buildCurrentTabSlivers(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCurrentTabSlivers() {
    const String jobDescription = """
# Product Designer  

We are looking for a **creative, detail-oriented Product Designer** to join our growing team. You will be responsible for designing intuitive, engaging, and delightful experiences for our users.  

---

## 📌 Responsibilities  

- Collaborate with product managers, engineers, and stakeholders to define user requirements.  
- Create wireframes, mockups, and interactive prototypes that clearly illustrate how products function and look.  
- Develop user flows, journey maps, and design systems that ensure consistency across platforms.  
- Conduct user research, usability testing, and iterate based on feedback.  
- Translate business and user needs into elegant and functional designs.  
- Work closely with engineering teams to ensure accurate implementation of designs.  
- Stay updated with the latest UI/UX trends, tools, and technologies.  

---

## 🛠 Skills & Qualifications  

- Bachelor’s degree in Design, HCI, or a related field (or equivalent experience).  
- Proven experience as a **Product Designer, UX/UI Designer, or similar role**.  
- Strong portfolio showcasing design projects and problem-solving skills.  
- Proficiency in design tools such as **Figma, Sketch, Adobe XD, or InVision**.  
- Understanding of responsive design and accessibility best practices.  
- Experience with user research and usability testing.  
- Excellent communication, presentation, and collaboration skills.  

---

## ⭐ Preferred Qualifications  

- Experience working in **Agile/Scrum** environments.  
- Knowledge of front-end technologies (HTML, CSS, Flutter, React, etc.).  
- Familiarity with design systems and component libraries.  
- Passion for crafting seamless user experiences that drive business impact.  

---

## 🎯 What We Offer  

- Competitive salary and benefits.  
- Flexible working hours and **remote-friendly culture**.  
- Opportunity to work on impactful products used by thousands of people.  
- Learning and growth opportunities with a collaborative team.  
- A culture that values creativity, innovation, and ownership.  

---

## 🚀 About the Role  

As a Product Designer, you’ll play a key role in shaping our product’s future. You’ll collaborate across teams, lead design initiatives, and bring innovative solutions to real-world problems. If you’re passionate about building experiences that users love, we’d love to hear from you!  

---
""";

    const String companyAbout = """
# 🌐 About Us  

At **DesignCraft Studios**, we believe great design has the power to change the way people interact with technology.  
We are a fast-growing product design and innovation company helping startups and enterprises craft **beautiful, user-friendly, and impactful digital experiences**.  

---

## 💡 Our Mission  
To empower businesses by designing products that are not only functional but also **delightful, accessible, and meaningful** for users worldwide.  

---

## 📈 What We Do  
- **Product Design & UX Strategy** – turning ideas into seamless user journeys.  
- **UI/Visual Design** – creating pixel-perfect, consistent, and scalable design systems.  
- **Prototyping & Testing** – validating concepts with real users before launch.  
- **Brand Identity & Storytelling** – ensuring design aligns with your brand values.  

---

## 🌍 Our Culture  
- We thrive on **creativity, collaboration, and continuous learning**.  
- We encourage open discussions, quick iterations, and ownership.  
- Remote-friendly and flexible working environment.  

---

## 🚀 Why Join Us?  
- Work with a passionate, global team of designers and innovators.  
- Get opportunities to design products used by **thousands of users**.  
- Competitive pay, flexible hours, and growth opportunities.  
- A supportive culture that values your ideas and contributions.  

---
""";

    switch (_tabController.index) {
      case 0:
        return [_sliverContact()];

      case 1:
        return [_sliverContact()];

      case 2:
        return [_sliverContact()];

      default:
        return [_sliverContact()];
    }
  }

  Widget _sliverContact() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              "We’re AquaFix Plumbing — your go-to team for leaks, clogs, and everything in between! Fast, friendly, and always reliable. We keep your water flowing and your worries gone!",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),

            Text(
              "We’d love to hear from you! Reach out to us anytime.",
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            // Phone
            ListTile(
              leading: Icon(
                Icons.phone,
                color: AppConstants.greenColor,
                size: 18,
              ),
              title: Text(
                "Phone",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppConstants.blackColor,
                ),
              ),
              subtitle: Text(
                "+1 234 567 890",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppConstants.blackColor.withValues(alpha: 0.5),
                ),
              ),
              onTap: () {}, // => _launchPhone("+1234567890"),
            ),

            // Email
            ListTile(
              leading: Icon(
                Icons.email,
                color: AppConstants.greenColor,
                size: 18,
              ),
              title: Text(
                "Email",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppConstants.blackColor,
                ),
              ),
              subtitle: Text(
                "contact@company.com",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppConstants.blackColor.withValues(alpha: 0.5),
                ),
              ),
              onTap: () {}, //=> _launchEmail("contact@designcraft.com"),
            ),

            const SizedBox(height: 16),
            Text(
              "Follow us",
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppConstants.blackColor,
              ),
            ),
            const SizedBox(height: 12),

            // Social Links
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.linked_camera,
                    color: AppConstants.greenColor,
                    size: 18,
                  ),
                  onPressed:
                      () {}, //=>   _launchURL("https://www.linkedin.com/company/designcraft"),
                ),
                IconButton(
                  icon: Icon(
                    Icons.alternate_email_rounded,
                    color: AppConstants.greenColor,
                    size: 18,
                  ),
                  onPressed:
                      () {}, //  => _launchURL("https://twitter.com/designcraft"),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.web,
                    color: AppConstants.greenColor,
                    size: 18,
                  ),
                  onPressed: () {}, //=> _launchURL("https://designcraft.com"),
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // Widget _sliverDescription(String data) {
  //   final config = isDarkMode
  //       ? MarkdownConfig.darkConfig
  //       : MarkdownConfig.defaultConfig;

  //   codeWrapper(child, text, language) =>
  //       CodeWrapperWidget(child, text, language);

  //   return SliverToBoxAdapter(
  //     child: MarkdownWidget(
  //       shrinkWrap: true,
  //       padding: const EdgeInsets.all(8),
  //       data: data,
  //       config: config.copy(
  //         configs: [
  //           isDarkMode!
  //               ? PreConfig.darkConfig.copy(
  //                   wrapper: codeWrapper,
  //                   padding: const EdgeInsets.only(
  //                     top: 15,
  //                     bottom: 8,
  //                     left: 8,
  //                     right: 8,
  //                   ),
  //                   textStyle: const TextStyle(fontSize: 12),
  //                   styleNotMatched: const TextStyle(fontSize: 12),
  //                   decoration: const BoxDecoration(
  //                     color: AppConstants.darkNavyBlueColor,
  //                   ),
  //                 )
  //               : PreConfig(
  //                   wrapper: codeWrapper,
  //                   padding: const EdgeInsets.only(
  //                     top: 15,
  //                     bottom: 8,
  //                     left: 8,
  //                     right: 8,
  //                   ),
  //                   textStyle: const TextStyle(fontSize: 12),
  //                   styleNotMatched: const TextStyle(fontSize: 12),
  //                 ),
  //           // .copy(wrapper: codeWrapper),
  //           const H1Config(
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //               letterSpacing: 0.5,
  //               wordSpacing: 1,
  //             ),
  //           ),
  //           const H2Config(
  //             style: TextStyle(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w600,
  //               letterSpacing: 0.5,
  //               wordSpacing: 1,
  //             ),
  //           ),
  //           const H3Config(
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.w500,
  //               letterSpacing: 0.5,
  //               wordSpacing: 1,
  //             ),
  //           ),

  //           const H4Config(style: TextStyle(fontSize: 12)),
  //           const H5Config(style: TextStyle(fontSize: 11)),
  //           const H6Config(style: TextStyle(fontSize: 10)),

  //           const TableConfig(),
  //           // Config()
  //         ],
  //       ),
  //       markdownGenerator: MarkdownGenerator(
  //         richTextBuilder: (span) => Text.rich(
  //           span,
  //           style: Theme.of(
  //             context,
  //           ).textTheme.labelSmall?.copyWith(fontSize: 10),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
