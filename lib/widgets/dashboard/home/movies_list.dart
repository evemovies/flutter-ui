import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/widgets/dashboard/home/movie_item.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> moviesList;

  const MoviesList({Key? key, required this.moviesList}) : super(key: key);

  List<List<Movie>> _getMoviePairs() {
    List<List<Movie>> result = [];

    for (var i = 0; i < moviesList.length; i += 2) {
      var end = i + 2 > moviesList.length ? moviesList.length : i + 2;

      result.add(moviesList.sublist(i, end));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var pairs = _getMoviePairs();

    return ListView.builder(
        itemCount: pairs.length,
        itemBuilder: (context, index) {
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
        });
  }
}
