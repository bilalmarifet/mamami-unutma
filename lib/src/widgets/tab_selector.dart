import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mamami_unutma/src/models/app_tab.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;
  static GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: bottomNavigationKey,
      backgroundColor: Colors.blueAccent,
      // currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        // return BottomNavigationBarItem(
        //   icon: Icon(
        //    ,
        //   ),
        //   label: tab == AppTab.stats ? 'Stats' : 'Posts',
        // );
        switch (tab) {
          case AppTab.posts:
            return Icon(
              Icons.list,
              size: 30,
            );
          case AppTab.add:
            return Icon(Icons.add);
          case AppTab.stats:
            return Icon(Icons.list);
        }
      }).toList(),
    );
  }
}
