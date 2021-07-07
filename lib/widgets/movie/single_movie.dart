import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/models/user_model.dart';

class SingleMovie extends StatelessWidget {
  final Movie movie;
  final User user;
  final Function(Movie) onAddMovie;
  final Function(Movie) onRemoveMovie;

  const SingleMovie(
      {Key? key, required this.movie, required this.user, required this.onAddMovie, required this.onRemoveMovie})
      : super(key: key);

  Widget _renderActionButton() {
    var movieInUserCollection = user.observableMovies.firstWhereOrNull((m) => m.id == movie.id);

    if (movieInUserCollection == null)
      return CupertinoButton.filled(child: Text('Add to collection'), onPressed: () => onAddMovie(movie));

    return CupertinoButton.filled(child: Text('Remove from collection'), onPressed: () => onRemoveMovie(movie));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            movie.posterUrl,
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(height: 25),
        Text('${movie.title} (${movie.year})'),
        SizedBox(height: 25),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text('Here should be some description, but we do not collect it just yet')),
        SizedBox(height: 25),
        _renderActionButton(),
        SizedBox(height: 25),
      ],
    ));
  }
}
