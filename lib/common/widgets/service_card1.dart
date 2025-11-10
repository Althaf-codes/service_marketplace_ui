import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app_ui/utils/constants.dart';

class ServiceCard1 extends StatelessWidget {
  const ServiceCard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppConstants.greyColor.withValues(alpha: 0.5),
        // AppConstants.greyColor.withValues(alpha: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140.h,
            width: 220,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // color: Colors.green,
            ),
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9qim3qhmi-J1zr4IgOqCBLIgxK2N4hdleNQ&s",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 3),
          Container(
            // height: 20,
            // width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppConstants.greyColor.withValues(alpha: 0.5),
            ),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              "Available",
              style: GoogleFonts.roboto(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppConstants.greenColor,

                backgroundColor: Colors.green.withValues(alpha: 0.2),
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.green,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),

          // SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(width: 10),
                Text(
                  "Bathroom Cleaning",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppConstants.blackColor,
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
            padding: const EdgeInsets.only(left: 2),
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
        ],
      ),
    );
  }
}
