import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/widgets/home/movie_item.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> moviesList;

  const MoviesList({Key? key, required this.moviesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: size.height / 100,
        children: moviesList.map((movie) => MovieItem(movie: movie)).toList());
  }
}
