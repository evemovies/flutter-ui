import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/widgets/dashboard/home_tab.dart';
import 'package:eve_mobile/widgets/dashboard/settings_tab.dart';
import 'package:eve_mobile/widgets/dashboard/add_movie_tab.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  static const routeName = '/dashboard';

  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _activeIndex = 0;

  void _handleTabUpdate(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Dashboard'),
      ),
      child: SafeArea(
        bottom: false,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            onTap: _handleTabUpdate,
            items: [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Movies'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled), label: 'Add'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings')
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return HomeTab(isActive: _activeIndex == HomeTab.tabIndex);
              case 1:
                return AddMovieTab(isActive: _activeIndex == AddMovieTab.tabIndex);
              case 2:
                return SettingsTab();
              default:
                return HomeTab(isActive: _activeIndex == HomeTab.tabIndex);
            }
          },
        ),
      ),
    );
  }
}
