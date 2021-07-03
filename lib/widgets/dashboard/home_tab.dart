import 'package:eve_mobile/providers/movie_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/user_provider.dart';
import 'package:eve_mobile/widgets/movie/movies_list.dart';

class HomeTab extends StatefulWidget {
  static const tabIndex = 0;
  final bool isActive;

  const HomeTab({Key? key, required this.isActive}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _shouldResetMovies = true;
  Future? _getUserFuture;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _getUserFuture = Provider.of<UserProvider>(context, listen: false).getUser();
    });
  }

  @override
  void didUpdateWidget(covariant HomeTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && _shouldResetMovies) {
      Future.delayed(Duration.zero, () {
        // Active movies are the ones that user has in the library
        var user = Provider.of<UserProvider>(context, listen: false).user;

        Provider.of<MovieProvider>(context, listen: false).setActiveMoviesList(movies: user.observableMovies);

        _shouldResetMovies = false;
      });
    } else if (!widget.isActive) {
      _shouldResetMovies = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<UserProvider>(builder: (context, userProvider, child) {
              return MoviesList(moviesList: userProvider.user.observableMovies);
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
