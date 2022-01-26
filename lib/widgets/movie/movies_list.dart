import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/widgets/movie/movie_item.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> moviesList;
  final Future<void> Function() onMovieRefresh;
  final String? emptyMessage;
  final String? errorMessage;

  const MoviesList(
      {Key? key, required this.moviesList, required this.onMovieRefresh, this.emptyMessage, this.errorMessage})
      : super(key: key);

  List<List<Movie>> _getMoviePairs() {
    List<List<Movie>> result = [];

    for (var i = 0; i < moviesList.length; i += 2) {
      var end = i + 2 > moviesList.length ? moviesList.length : i + 2;

      result.add(moviesList.sublist(i, end));
    }

    return result;
  }

  _renderMessage() {
    var defaultMessage = 'No movies to display';

    return Center(child: Text(errorMessage ?? emptyMessage ?? defaultMessage));
  }

  @override
  Widget build(BuildContext context) {
    var pairs = _getMoviePairs();

    if (moviesList.length == 0) return _renderMessage();

    return CustomScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: onMovieRefresh),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          var children = pairs[index].asMap().entries.map((e) {
            return Expanded(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: MovieItem(
                movie: pairs[index][e.key],
              ),
            ));
          }).toList();

          // Imitate one more slot
          if (children.length == 1) children.add(Expanded(child: Container()));

          return Row(
            children: children,
          );
        }, childCount: pairs.length))
      ],
    );
  }
}
