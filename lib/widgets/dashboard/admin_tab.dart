import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eve_mobile/providers/admin_provider.dart';
import 'package:eve_mobile/providers/user_provider.dart';

final adminId = dotenv.env['ADMIN_ID'];

class AdminTab extends StatefulWidget {
  const AdminTab({Key? key}) : super(key: key);

  @override
  _AdminTabState createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {
  void _refreshStats() {
    Provider.of<AdminProvider>(context, listen: false).getStats();
  }

  Widget _renderUnauthorizedMessage() {
    return Center(child: Text('You have no power here!'));
  }

  Widget _renderErrorMessage(String errorMessage) {
    if (errorMessage.isEmpty) return Container();

    return Text(errorMessage);
  }

  Widget _renderGetStatsButton() {
    return Center(child: CupertinoButton.filled(child: Text('Get stats'), onPressed: _refreshStats));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      if (userProvider.user.id != adminId) return _renderUnauthorizedMessage();

      return Consumer<AdminProvider>(builder: (context, adminProvider, child) {
        if (adminProvider.stats == null && adminProvider.errorMessage.isEmpty) return _renderGetStatsButton();
        if (adminProvider.stats == null && adminProvider.errorMessage.isNotEmpty) return _renderUnauthorizedMessage();

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('All users: ${adminProvider.stats?.usersAll}'),
              Text('Created today users: ${adminProvider.stats?.usersCreatedToday}'),
              Text('Active today users: ${adminProvider.stats?.usersActiveToday}'),
              SizedBox(height: 20),
              _renderErrorMessage(adminProvider.errorMessage),
              CupertinoButton.filled(child: Text('Refresh'), onPressed: _refreshStats)
            ],
          ),
        );
      });
    });
  }
}
