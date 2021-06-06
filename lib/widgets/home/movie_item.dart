import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Movie, ${movie.title}'),
    );
  }
}
