import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/auth_provider.dart';
import 'package:eve_mobile/providers/user_provider.dart';
import 'package:eve_mobile/providers/movie_provider.dart';
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
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProxyProvider<UserProvider, MovieProvider>(
              create: (BuildContext context) => MovieProvider(Provider.of<UserProvider>(context, listen: false).user),
              update: (context, userProvider, movieProvider) =>
                  movieProvider!..setActiveMoviesList(movies: userProvider.user.observableMovies))
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
