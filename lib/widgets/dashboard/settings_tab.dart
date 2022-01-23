import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eve_mobile/views/login_view.dart';
import 'package:eve_mobile/providers/auth_provider.dart';
import 'package:eve_mobile/providers/user_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  void _handleLogout(BuildContext context) async {
    await Provider.of<AuthProvider>(context, listen: false).logout();

    Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (r) => false);
  }

  void _showAboutMessage(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text('About this app'),
              content: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text:
                          'This is a companion app for the Eve. Here you can do most of the thing that are available in Telegram. This project is open-sourced and available in ',
                      style: TextStyle(color: CupertinoColors.black)),
                  TextSpan(
                      text: 'https://github.com/evemovies/flutter-ui',
                      style: TextStyle(color: CupertinoColors.systemBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://github.com/evemovies/flutter-ui');
                          Navigator.of(context).pop();
                        })
                ]),
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    var isProduction = bool.fromEnvironment('dart.vm.product');

    return SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Consumer<UserProvider>(
                builder: (context, userProvider, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text('Your account summary: ')),
                        Text(
                          'Version: unspecified',
                        ),
                        Text('Username: ${userProvider.user.username}'),
                        Text('ID: ${userProvider.user.id}'),
                        Text('Movies notifications sent: ${userProvider.user.totalMovies}'),
                        Text('Production: $isProduction'),
                        Spacer(),
                        Center(
                            child: CupertinoButton(child: Text('About'), onPressed: () => _showAboutMessage(context))),
                        Center(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: CupertinoButton(
                                    color: CupertinoColors.systemRed,
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(color: CupertinoColors.white),
                                    ),
                                    onPressed: () => _handleLogout(context)))),
                      ],
                    ))));
  }
}
