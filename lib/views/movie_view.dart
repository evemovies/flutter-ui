import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/movies_provider.dart';
import 'package:eve_mobile/widgets/movie/single_movie.dart';

class MovieViewRouteArgs {
  final String movieId;

  MovieViewRouteArgs({required this.movieId});
}

class MovieView extends StatelessWidget {
  static const routeName = '/movie';

  const MovieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context)!.settings.arguments as MovieViewRouteArgs;
    var movieId = routeArgs.movieId;
    var movie = Provider.of<MoviesProvider>(context).getMovieById(movieId);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(movie.title),
      ),
      child: SafeArea(
        child: SingleMovie(movie: movie),
      ),
    );
  }
}
