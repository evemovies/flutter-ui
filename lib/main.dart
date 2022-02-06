import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eve_mobile/providers/auth_provider.dart';
import 'package:eve_mobile/providers/user_provider.dart';
import 'package:eve_mobile/providers/movie_provider.dart';
import 'package:eve_mobile/providers/theme_provider.dart';
import 'package:eve_mobile/providers/admin_provider.dart';
import 'package:eve_mobile/views/dashboard_view.dart';
import 'package:eve_mobile/views/login_view.dart';
import 'package:eve_mobile/views/movie_view.dart';

void main() async {
  await dotenv.load();

  runApp(EveMobile());
}

class EveMobile extends StatefulWidget {
  const EveMobile({Key? key}) : super(key: key);

  @override
  _EveMobileState createState() => _EveMobileState();
}

class _EveMobileState extends State<EveMobile> with WidgetsBindingObserver {
  Brightness? _systemBrightness;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _systemBrightness = WidgetsBinding.instance?.window.platformBrightness;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        _systemBrightness = WidgetsBinding.instance?.window.platformBrightness;
      });
    }
    super.didChangePlatformBrightness();
  }

  CupertinoThemeData _getAppTheme(ThemeOption savedTheme) {
    if (savedTheme == ThemeOption.system) return CupertinoThemeData(brightness: _systemBrightness);
    if (savedTheme == ThemeOption.light) return CupertinoThemeData(brightness: Brightness.light);

    return CupertinoThemeData(brightness: Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => AdminProvider()),
          ChangeNotifierProxyProvider<UserProvider, MovieProvider>(
              create: (BuildContext context) => MovieProvider(Provider.of<UserProvider>(context, listen: false).user),
              update: (context, userProvider, movieProvider) =>
                  movieProvider!..setUserMoviesList(movies: userProvider.user.observableMovies))
        ],
        child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) => CupertinoApp(
                  title: 'EveMovies',
                  theme: _getAppTheme(themeProvider.theme),
                  initialRoute: LoginView.routeName,
                  routes: {
                    DashboardView.routeName: (context) => DashboardView(),
                    LoginView.routeName: (context) => LoginView(),
                    MovieView.routeName: (context) => MovieView(),
                  },
                )));
  }
}
