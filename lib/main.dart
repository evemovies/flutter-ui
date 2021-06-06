import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/auth_provider.dart';
import 'package:eve_mobile/providers/movies_provider.dart';
import 'package:eve_mobile/views/dashboard_view.dart';
import 'package:eve_mobile/views/login_view.dart';

void main() {
  runApp(EveMobile());
}

class EveMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => MoviesProvider())
        ],
        child: CupertinoApp(
          title: 'EveMovies',
          initialRoute: Login.routeName,
          routes: {
            Dashboard.routeName: (context) => Dashboard(),
            Login.routeName: (context) => Login()
          },
        ));
  }
}
