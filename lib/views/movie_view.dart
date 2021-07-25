import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/movie_provider.dart';
import 'package:eve_mobile/providers/user_provider.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/widgets/movie/single_movie.dart';

class MovieViewRouteArgs {
  final String movieId;

  MovieViewRouteArgs({required this.movieId});
}

class MovieView extends StatefulWidget {
  static const routeName = '/movie';

  const MovieView({Key? key}) : super(key: key);

  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  String _errorMessage = '';

  void _handleAddMovie(BuildContext context, Movie movie) async {
    var error = await Provider.of<UserProvider>(context, listen: false).addMovieToCollection(movie);

    if (error != null) {
      setState(() {
        _errorMessage = error;
      });
    } else {
      setState(() {
        _errorMessage = '';
      });
    }
  }

  void _handleRemoveMovie(BuildContext context, Movie movie) {
    Provider.of<UserProvider>(context, listen: false).removeMovieFromCollection(movie.id);
  }

  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context)!.settings.arguments as MovieViewRouteArgs;
    var movieId = routeArgs.movieId;

    return Consumer2<UserProvider, MovieProvider>(builder: (context, userProvider, movieProvider, child) {
      var movie = movieProvider.getMovie(movieId);

      return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(movie.title),
          ),
          child: SafeArea(
              child: SingleMovie(
            movie: movie,
            user: userProvider.user,
            errorMessage: _errorMessage,
            onAddMovie: (movie) => _handleAddMovie(context, movie),
            onRemoveMovie: (movie) => _handleRemoveMovie(context, movie),
          )));
    });
  }
}
