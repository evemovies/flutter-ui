import 'package:eve_mobile/widgets/movie/movies_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/movie_provider.dart';

class AddMovieTab extends StatefulWidget {
  static const tabIndex = 1;
  final bool isActive;

  const AddMovieTab({Key? key, required this.isActive}) : super(key: key);

  @override
  _AddMovieTabState createState() => _AddMovieTabState();
}

class _AddMovieTabState extends State<AddMovieTab> {
  TextEditingController _movieTitle = TextEditingController(text: '');

  void _searchMovies() async {
    await Provider.of<MovieProvider>(context, listen: false).searchMovies(title: _movieTitle.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: CupertinoTextField(
              controller: _movieTitle,
              placeholder: 'Movie title',
            )),
            CupertinoButton.filled(child: Icon(CupertinoIcons.search), onPressed: _searchMovies)
          ],
        ),
        Consumer<MovieProvider>(builder: (context, movieProvider, child) {
          return Flexible(child: MoviesList(moviesList: movieProvider.foundMovies));
        })
      ],
    );
  }
}
