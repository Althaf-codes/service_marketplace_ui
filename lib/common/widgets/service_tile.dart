// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app_ui/screens/category/category_screen.dart';

import 'package:salon_app_ui/utils/constants.dart';

class ServiceTile extends StatelessWidget {
  final String img;
  final String label;

  const ServiceTile({super.key, required this.img, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => CategoryScreen()));
      },
      child: Container(
        padding: EdgeInsets.only(top: 6, bottom: 6, left: 6, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: AppConstants.greyColor.withValues(alpha: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppConstants.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(img, fit: BoxFit.cover),
                ),
                SizedBox(width: 10),
                Text(
                  label,
                  style: GoogleFonts.roboto(
                    color: AppConstants.blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
              color: AppConstants.greenColor,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
