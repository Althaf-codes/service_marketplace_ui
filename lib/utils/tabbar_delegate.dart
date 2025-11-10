import 'package:flutter/material.dart';
import 'package:salon_app_ui/utils/constants.dart';

class TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  final bool isDarkMode;
  TabBarHeaderDelegate(this._tabBar, {required this.isDarkMode});

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      elevation: overlapsContent ? 1 : 0,
      color: AppConstants.whiteColor,
      child: _tabBar,
    );
  }

  // @override
  // bool shouldRebuild(TabBarHeaderDelegate oldDelegate) => false;
  @override
  bool shouldRebuild(TabBarHeaderDelegate oldDelegate) {
    return isDarkMode != oldDelegate.isDarkMode ||
        _tabBar != oldDelegate._tabBar;
  }
}
