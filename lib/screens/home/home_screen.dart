import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app_ui/common/widgets/service_card1.dart';
import 'package:salon_app_ui/common/widgets/service_tile.dart';
import 'package:salon_app_ui/utils/constants.dart';
import 'package:salon_app_ui/utils/custom_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;

  final List<Map<String, String>> _services = [
    {"Hairdresser": AppConstants.hairDryerImg},
    {"Cleaning": AppConstants.paintBrushImg},
    {"Painting": AppConstants.paletteImg},
    {"Cooking": AppConstants.chefHatImg},
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: AppConstants.greenColor,
        title: Row(
          children: [
            Icon(
              CustomIcons.location_outline,
              size: 18,
              color: AppConstants.whiteColor,
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Location",
                  style: GoogleFonts.roboto(
                    color: AppConstants.whiteColor,
                    letterSpacing: 0.5,

                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "San Antinoe, Tx",
                      style: GoogleFonts.roboto(
                        color: AppConstants.whiteColor,
                        letterSpacing: 0.5,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons
                            .arrow_forward_ios_outlined, //arrow_drop_down_outlined,
                        size: 14,
                        color: AppConstants.whiteColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                // DropdownButton(
                //   value: "San Antinoe, Tx",
                //   items: [],
                //   onChanged: (val) {},
                // ),
              ],
            ),
          ],
        ),

        actions: [
          Badge(
            backgroundColor: AppConstants.whiteColor,
            smallSize: 10,
            // alignment: Alignment.topRight,
            offset: Offset(4, -10),
            // largeSize: 20,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white12,
                // .withValues(alpha: 0.2),
              ),
              child: Center(
                child: Icon(
                  Icons.notifications_outlined,
                  size: 18,
                  color: AppConstants.whiteColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppConstants.whiteColor, width: 1),
              color: Colors.white30,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child: Image.network(
                "https://thumbs.dreamstime.com/b/face-beautiful-woman-long-brown-curly-hair-posing-studio-over-dark-background-face-beautiful-sexy-woman-157715109.jpg",
                // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD7SrXdD9xUq03O9IUm5P-p-Uq4exwdjmXNg&s",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.425, // 0.425,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: AppConstants.greenColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.13),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8.0,
                    ),
                    child: TextField(
                      controller: _searchController,
                      cursorColor: AppConstants.greenColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppConstants.whiteColor,
                        hintText: "Search for a service",
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppConstants.greenColor,
                        ),
                        prefixIcon: const Icon(
                          CustomIcons.search,
                          size: 18,
                          color: AppConstants.greenColor,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              )
                            : null,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ), // Stadium shape
                          borderSide: BorderSide.none, // Removes outline
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          borderSide: BorderSide.none,

                          // borderSide: BorderSide(
                          //   color: AppConstants.greenColor,
                          //   width: 1.5,
                          // ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0,
                        ),
                      ),
                      onChanged: (query) {},
                    ),
                  ),
                  // SizedBox(height: 8),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.16,
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        // color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "YOUR SOLUTION, ONE TAP AWAY!",
                              style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                                color: AppConstants.whiteColor,
                              ),
                            ),
                            Text(
                              '''Seamless, Fast & Reliable Service at Your Fingertips''',
                              style: GoogleFonts.roboto(
                                fontSize: 8,
                                fontWeight: FontWeight.w300,
                                color: AppConstants.whiteColor,
                              ),
                            ),

                            SizedBox(height: 15),
                            // Spacer(),
                            TextButton(
                              onPressed: () {},

                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Explore",
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppConstants.greenColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset(
                          AppConstants.bannerImg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Service Categories",
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
            SizedBox(
              // color: Colors.amber,
              // height: MediaQuery.sizeOf(context).height * 0.2,
              width: MediaQuery.sizeOf(context).width,
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 16 / 5,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  Map _service = _services[index];
                  return ServiceTile(
                    img: _service.values.first,
                    label: _service.keys.first,
                  );
                },
              ),
            ),

            SizedBox(height: 10),
            Padding(
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
            SizedBox(
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
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
