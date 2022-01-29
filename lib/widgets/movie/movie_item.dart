import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/views/movie_view.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final bool animate;

  const MovieItem({Key? key, required this.movie, required this.animate}) : super(key: key);

  void _handleMovieTap(BuildContext context) {
    Navigator.pushNamed(context, MovieView.routeName, arguments: MovieViewRouteArgs(movieId: movie.id));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleMovieTap(context),
      child: AnimatedContainer(
          margin: EdgeInsetsDirectional.only(top: animate ? 0 : 200),
          duration: Duration(milliseconds: 500),
          child: Column(children: [
            Image.network(
              movie.posterUrl,
              height: 350,
            ),
            Text(movie.title, overflow: TextOverflow.ellipsis)
          ])),
    );
  }
}
