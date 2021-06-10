import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/movies_provider.dart';
import 'package:eve_mobile/widgets/dashboard/home/movies_list.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future? _getMoviesFuture;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _getMoviesFuture = Provider.of<MoviesProvider>(context, listen: false).getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getMoviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<MoviesProvider>(builder: (context, moviesProvider, child) {
              return MoviesList(moviesList: moviesProvider.movies);
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
