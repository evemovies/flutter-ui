import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/auth_provider.dart';
import 'package:eve_mobile/views/login_view.dart';
import 'package:eve_mobile/providers/user_provider.dart';
import 'package:eve_mobile/widgets/movie/movies_list.dart';
import 'package:eve_mobile/models/user_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future? _getUserFuture;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _getUserFuture = Provider.of<UserProvider>(context, listen: false).getUser();
    });
  }

  Widget _renderMoviesListOrRedirect(User user) {
    if (user.id.isEmpty) {
      Provider.of<AuthProvider>(context, listen: false).logout().then((value) {
        Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (r) => false);
      });

      return Container();
    } else {
      return MoviesList(
        moviesList: user.observableMovies,
        emptyMessage: 'You have no movies in your library',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<UserProvider>(builder: (context, userProvider, child) {
              return _renderMoviesListOrRedirect(userProvider.user);
            });
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        });
  }
}
