import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app_ui/utils/constants.dart';
import 'package:salon_app_ui/utils/custom_icons.dart';

class StoreTile extends StatelessWidget {
  final VoidCallback onPressed;
  const StoreTile({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppConstants.whiteColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 18, backgroundColor: Colors.black),
              SizedBox(width: 5),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Elite Services",
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
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

                  Row(
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
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // height: 20.h,
                  // width: MediaQuery.sizeOf(context).width * 0.4,
                  child: ElevatedButton(
                    onPressed: onPressed,

                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
                      backgroundColor: WidgetStatePropertyAll(
                        AppConstants.greyColor.withValues(alpha: 0.9),
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CustomIcons.chat_empty,
                          color: AppConstants.greenColor,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Chat",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.greenColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  // height: 20.h,
                  // width: MediaQuery.sizeOf(context).width * 0.4,
                  child: ElevatedButton(
                    onPressed: onPressed,

                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
                      backgroundColor: WidgetStatePropertyAll(
                        AppConstants.greenColor,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call_outlined,
                          color: AppConstants.whiteColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Call",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppConstants.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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
