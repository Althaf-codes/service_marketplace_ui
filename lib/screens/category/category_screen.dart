import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app_ui/common/widgets/service_card2.dart';
import 'package:salon_app_ui/common/widgets/store_tile.dart';
import 'package:salon_app_ui/screens/store/store_detail_screen.dart';
import 'package:salon_app_ui/utils/constants.dart';
import 'package:salon_app_ui/utils/custom_icons.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _searchController;
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppConstants.whiteColor,
        leadingWidth: 50,

        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 20,
              width: 20,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppConstants.greyColor.withValues(alpha: 0.6),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 22,
                color: AppConstants.blackColor,
              ),
            ),
          ),
        ),
        title: Text(
          "Hairdresser",
          style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),

      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60.h, // MediaQuery.sizeOf(context).height * 0.2,
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.symmetric(horizontal: 12),
                // color: Colors.blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: MediaQuery.sizeOf(context).width * 0.8,

                      child: TextField(
                        controller: _searchController,
                        cursorColor: AppConstants.greenColor,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppConstants.greyColor.withValues(
                            alpha: 0.5,
                          ),
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
                    Container(
                      height: 50.h,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppConstants.greyColor.withValues(alpha: 0.5),
                      ),
                      child: Icon(
                        CustomIcons.sliders,
                        size: 22,
                        color: AppConstants.blackColor,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
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
                      "Services",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Stores",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.65, // 0.72,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 8),
                color: AppConstants.greyColor.withValues(alpha: 0.6),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => StoreDetailScreen(),
                                ),
                              );
                            },
                            child: ServiceCard2(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StoreDetailScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => StoreDetailScreen(),
                                ),
                              );
                            },
                            child: StoreTile(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StoreDetailScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
