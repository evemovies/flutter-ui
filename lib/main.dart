import 'package:eve_mobile/providers/auth_provider.dart';
import 'package:eve_mobile/views/dashboard_view.dart';
import 'package:eve_mobile/views/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(EveMobile());
}

class EveMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: CupertinoApp(
          title: 'EveMovies',
          initialRoute: '/login',
          routes: {'/': (context) => Dashboard(), '/login': (context) => Login()},
        ));
  }
}
