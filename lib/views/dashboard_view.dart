import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/widgets/dashboard/home_tab.dart';
import 'package:eve_mobile/widgets/dashboard/settings_tab.dart';
import 'package:eve_mobile/widgets/dashboard/add_movie_tab.dart';
import 'package:eve_mobile/widgets/dashboard/admin_tab.dart';

const SETTINGS_TAB_ID = 2;

class DashboardView extends StatefulWidget {
  static const routeName = '/dashboard';

  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _showAdminTab = false;
  int _adminTabCounter = 0;

  void _handleNavigationBarTap(int index) {
    if (_showAdminTab) return;

    var newCounterValue = index == SETTINGS_TAB_ID ? _adminTabCounter + 1 : 0;

    setState(() {
      _adminTabCounter = newCounterValue;
    });

    if (_adminTabCounter == 10) {
      setState(() {
        _showAdminTab = true;
      });
    }
  }

  List<BottomNavigationBarItem> _getNavigationBarItems() {
    var items = [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Movies'),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled), label: 'Add'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        label: 'Settings',
      ),
    ];

    if (_showAdminTab) {
      items.add(BottomNavigationBarItem(icon: Icon(CupertinoIcons.burn), label: 'Admin'));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        middle: Text(
          'Dashboard',
          style: TextStyle(color: CupertinoColors.black),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: CupertinoTabScaffold(
          backgroundColor: CupertinoColors.white,
          tabBar: CupertinoTabBar(
            backgroundColor: CupertinoColors.extraLightBackgroundGray,
            onTap: _handleNavigationBarTap,
            items: _getNavigationBarItems(),
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return HomeTab();
              case 1:
                return AddMovieTab();
              case 2:
                return SettingsTab();
              case 3:
                return AdminTab();
              default:
                return HomeTab();
            }
          },
        ),
      ),
    );
  }
}
