import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/widgets/movie/movie_item.dart';

class MoviesList extends StatefulWidget {
  final List<Movie> moviesList;
  final Future<void> Function() onMovieRefresh;
  final String? emptyMessage;
  final String? errorMessage;

  const MoviesList(
      {Key? key, required this.moviesList, required this.onMovieRefresh, this.emptyMessage, this.errorMessage})
      : super(key: key);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  bool animate = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        animate = true;
      });
    });
  }

  List<List<Movie>> _getMoviePairs() {
    List<List<Movie>> result = [];

    for (var i = 0; i < widget.moviesList.length; i += 2) {
      var end = i + 2 > widget.moviesList.length ? widget.moviesList.length : i + 2;

      result.add(widget.moviesList.sublist(i, end));
    }

    return result;
  }

  _renderMessage() {
    var defaultMessage = 'No movies to display';

    return Center(child: Text(widget.errorMessage ?? widget.emptyMessage ?? defaultMessage));
  }

  @override
  Widget build(BuildContext context) {
    var pairs = _getMoviePairs();

    if (widget.moviesList.length == 0) return _renderMessage();

    return Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: widget.onMovieRefresh),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              var children = pairs[index].asMap().entries.map((e) {
                return Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8),
                  child: MovieItem(
                    movie: pairs[index][e.key],
                    animate: animate,
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
        ));
  }
}
