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

class MovieView extends StatelessWidget {
  static const routeName = '/movie';

  const MovieView({Key? key}) : super(key: key);

  void _handleAddMovie(BuildContext context, Movie movie) {
    Provider.of<UserProvider>(context, listen: false).addMovieToCollection(movie);
  }

  void _handleRemoveMovie(BuildContext context, Movie movie) {
    Provider.of<UserProvider>(context, listen: false).removeMovieFromCollection(movie.id);
  }

  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context)!.settings.arguments as MovieViewRouteArgs;
    var movieId = routeArgs.movieId;
    var movie = Provider.of<MovieProvider>(context, listen: false).getMovie(movieId);
    var user = Provider.of<UserProvider>(context, listen: false).user;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(movie.title),
      ),
      child: SafeArea(
        child: SingleMovie(
          movie: movie,
          user: user,
          onAddMovie: (movie) => _handleAddMovie(context, movie),
          onRemoveMovie: (movie) => _handleRemoveMovie(context, movie),
        ),
      ),
    );
  }
}
