import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eve_mobile/providers/user_provider.dart';

final adminId = dotenv.env['ADMIN_ID'];

class AdminTab extends StatefulWidget {
  const AdminTab({Key? key}) : super(key: key);

  @override
  _AdminTabState createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      if (userProvider.user.id == adminId) {
        return Center(child: Text("One place to rule'em all"));
      }

      return Center(child: Text('You have no power here!'));
    });
  }
}
