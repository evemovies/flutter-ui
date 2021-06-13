import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/auth_provider.dart';
import 'package:eve_mobile/providers/user_provider.dart';
import 'package:eve_mobile/views/dashboard_view.dart';
import 'package:eve_mobile/views/login_view.dart';
import 'package:eve_mobile/views/movie_view.dart';

void main() {
  runApp(EveMobile());
}

class EveMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider())
        ],
        child: CupertinoApp(
          title: 'EveMovies',
          initialRoute: LoginView.routeName,
          routes: {
            DashboardView.routeName: (context) => DashboardView(),
            LoginView.routeName: (context) => LoginView(),
            MovieView.routeName: (context) => MovieView(),
          },
        ));
  }
}
