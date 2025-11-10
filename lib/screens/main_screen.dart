import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app_ui/screens/category/category_screen.dart';
import 'package:salon_app_ui/screens/chat/chat_screen.dart';
import 'package:salon_app_ui/screens/home/home_screen.dart';
import 'package:salon_app_ui/screens/profile/profile_screen.dart';
import 'package:salon_app_ui/screens/schedule/schedule_screen.dart';
import 'package:salon_app_ui/screens/store/store_detail_screen.dart';
import 'package:salon_app_ui/utils/constants.dart';
import 'package:salon_app_ui/utils/custom_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<Widget> _screens = [
    // StoreDetailScreen(),
    // CategoryScreen(),
    HomeScreen(),
    ScheduleScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],

      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.only(left: 14, right: 14),
        color: Colors.white, // AppConstants.darkNavyBlueColor, //Colors.black,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < 4; i++)
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    currentIndex = i;
                  });
                },
                //  context
                //     .read<BottomNavCubit>()
                //     .setIndex(i, context),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: currentIndex == i ? 18 : 0,
                  ),
                  decoration: currentIndex == i
                      ? BoxDecoration(
                          color: AppConstants.greenColor,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white),
                        )
                      : null,
                  child: Row(
                    children: [
                      Icon(
                        currentIndex == i ? _getActiveIcon(i) : _getIcon(i),
                        size: i >= 2 ? 20 : 18,
                        color: currentIndex == i ? Colors.white : Colors.black,
                      ),
                      const SizedBox(width: 5),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: currentIndex == i
                            ? Text(
                                _getLabel(i),
                                key: ValueKey<String>(_getLabel(i)),
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),

      //  BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   onTap: (int index) {
      //     setState(() {
      //       currentIndex = index;
      //     });
      //   },
      //   type: BottomNavigationBarType.shifting,
      //   items: [
      //     BottomNavigationBarItem(
      //       label: "Home",
      //       icon: Icon(CustomIcons.home_outline),
      //       activeIcon: Icon(CustomIcons.home),
      //     ),
      //     BottomNavigationBarItem(
      //       label: "Calender",
      //       icon: Icon(CustomIcons.calendar_empty),
      //       activeIcon: Icon(CustomIcons.calendar),
      //     ),
      //     BottomNavigationBarItem(
      //       label: "Chat",
      //       icon: Icon(CustomIcons.chat_empty),
      //       activeIcon: Icon(CustomIcons.chat_1),
      //     ),
      //     BottomNavigationBarItem(
      //       label: "Profile",
      //       icon: Icon(CustomIcons.person_outline),
      //       activeIcon: Icon(CustomIcons.person),
      //     ),
      //   ],
      // ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return CustomIcons.home_outline;
      case 1:
        return CustomIcons.calendar_empty;
      case 2:
        return CustomIcons.chat_empty;
      case 3:
        return CustomIcons.person_outline;
      default:
        return Icons.home_outlined;
    }
  }

  IconData _getActiveIcon(int index) {
    switch (index) {
      case 0:
        return CustomIcons.home;
      case 1:
        return CustomIcons.calendar;
      case 2:
        return CustomIcons.chat_1;
      case 3:
        return CustomIcons.person;
      default:
        return Icons.home;
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Schedule";
      case 2:
        return "Chat";
      case 3:
        return "Profile";
      default:
        return "Home";
    }
  }
}
