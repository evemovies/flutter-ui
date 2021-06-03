import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/views/home_view.dart';
import 'package:eve_mobile/views/settings_view.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/';

  const Dashboard({Key? key}) : super(key: key);

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
            items: [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings')
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return HomeView();
              case 1:
                return SettingsView();
              default:
                return HomeView();
            }
          },
        ),
      ),
    );
  }
}
