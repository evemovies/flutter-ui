import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/models/user_model.dart';

class SingleMovie extends StatelessWidget {
  final Movie movie;
  final User user;
  final String? errorMessage;
  final Function(Movie) onAddMovie;
  final Function(Movie) onRemoveMovie;

  const SingleMovie(
      {Key? key,
      required this.movie,
      required this.user,
      this.errorMessage,
      required this.onAddMovie,
      required this.onRemoveMovie})
      : super(key: key);

  Widget _renderActionButton() {
    var movieInUserCollection = user.observableMovies.firstWhereOrNull((m) => m.id == movie.id);

    if (movieInUserCollection == null)
      return CupertinoButton.filled(
          child: Text(
            'Add to collection',
            style: TextStyle(color: CupertinoColors.white),
          ),
          onPressed: () => onAddMovie(movie));

    return CupertinoButton.filled(
        child: Text(
          'Remove from collection',
          style: TextStyle(color: CupertinoColors.white),
        ),
        onPressed: () => onRemoveMovie(movie));
  }

  Widget _renderErrorMessage() {
    if (errorMessage != null) {
      return Column(
        children: [
          Text(
            errorMessage!,
            style: TextStyle(color: CupertinoColors.systemRed),
          ),
          SizedBox(
            height: 10,
          )
        ],
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Spacer(),
        _renderErrorMessage(),
        _renderActionButton(),
        // SizedBox(height: 15),
      ],
    );
  }
}
