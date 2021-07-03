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
  bool _shouldResetMovies = false;
  TextEditingController _movieTitle = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

    // A hack because didUpdateWidget is not called on the first render
    Future.delayed(Duration.zero, () {
      Provider.of<MovieProvider>(context, listen: false).setActiveMoviesList(movies: []);
    });
  }

  @override
  void didUpdateWidget(covariant AddMovieTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && _shouldResetMovies) {
      Future.delayed(Duration.zero, () {
        Provider.of<MovieProvider>(context, listen: false).setActiveMoviesList(movies: []);

        _shouldResetMovies = false;
      });
    } else if (!widget.isActive) {
      // Switched to another tab, should reset movies again when navigating here next time
      _shouldResetMovies = true;
    }
  }

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
          return Flexible(child: MoviesList(moviesList: movieProvider.movies));
        })
      ],
    );
  }
}
