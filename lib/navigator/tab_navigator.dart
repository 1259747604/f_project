import 'package:f_project/pages/home_page.dart';
import 'package:f_project/pages/my_page.dart';
import 'package:f_project/pages/search_page.dart';
import 'package:f_project/pages/travel_page.dart';
import 'package:f_project/util/navigator_util.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(initialPage: 0);
  final defaultColor = Colors.grey;
  final activeColor = Colors.blue;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    NavigatorUtil.updateContext(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('搜索', Icons.search, 1),
          _bottomItem('旅拍', Icons.camera_alt, 2),
          _bottomItem('我的', Icons.account_circle, 3),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: activeColor,
        unselectedItemColor: defaultColor,
        selectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: defaultColor),
      activeIcon: Icon(icon, color: activeColor),
      label: title,
    );
  }
}
