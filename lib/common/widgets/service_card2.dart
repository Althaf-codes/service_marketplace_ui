import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app_ui/utils/constants.dart';
import 'package:salon_app_ui/utils/custom_icons.dart';

class ServiceCard2 extends StatelessWidget {
  final VoidCallback onPressed;
  const ServiceCard2({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325.h,
      // width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppConstants.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160.h,
            width: MediaQuery.sizeOf(context).width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // color: Colors.green,
            ),
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJfUcTu1ebjRB7FAQ492LggZ8AXQK_cgIScw&s",
              // "https://wigreports.com/wp-content/uploads/2021/07/how-to-make-a-wig-smaller-scaled-1-1024x576.jpg",
              // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9qim3qhmi-J1zr4IgOqCBLIgxK2N4hdleNQ&s",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 3),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Hair Dresser Home Visit",
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppConstants.blackColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "\$25 - \$30",
                  style: GoogleFonts.roboto(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.greenColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            // padding: const EdgeInsets.only(left: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),

            child: Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                Text(
                  "4.5",
                  style: GoogleFonts.roboto(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.blackColor,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "(123 Reviews)",
                  style: GoogleFonts.roboto(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.blackColor.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppConstants.blackColor,
                ),
                SizedBox(width: 6),
                Text(
                  "Elite Services",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 4),

                Image.asset(height: 15, width: 15, AppConstants.verifiedImg),
              ],
            ),
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // height: 20.h,
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: ElevatedButton(
                    onPressed: onPressed,

                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
                      backgroundColor: WidgetStatePropertyAll(
                        AppConstants.greenColor,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                    child: Text(
                      "Book Now",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.whiteColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppConstants.greyColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    CustomIcons.chat_empty,
                    color: AppConstants.greenColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
