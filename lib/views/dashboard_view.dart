import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/widgets/dashboard/home_tab.dart';
import 'package:eve_mobile/widgets/dashboard/settings_tab.dart';
import 'package:eve_mobile/widgets/dashboard/add_movie_tab.dart';

class DashboardView extends StatelessWidget {
  static const routeName = '/dashboard';

  const DashboardView({Key? key}) : super(key: key);

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
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Movies'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled), label: 'Add'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings')
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return HomeTab();
              case 1:
                return AddMovieTab();
              case 2:
                return SettingsTab();
              default:
                return HomeTab();
            }
          },
        ),
      ),
    );
  }
}
