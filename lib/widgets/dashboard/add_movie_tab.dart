import 'package:eve_mobile/widgets/movie/movies_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/movie_provider.dart';

class AddMovieTab extends StatefulWidget {
  const AddMovieTab({Key? key}) : super(key: key);

  @override
  _AddMovieTabState createState() => _AddMovieTabState();
}

class _AddMovieTabState extends State<AddMovieTab> {
  TextEditingController _movieTitle = TextEditingController(text: '');
  Future? _searchMoviesFuture;

  void _searchMovies(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _searchMoviesFuture = Provider.of<MovieProvider>(context, listen: false).searchMovies(title: _movieTitle.text);
    });
  }

  Future<void> _refreshMoviesList() async {
    await Provider.of<MovieProvider>(context, listen: false).searchMovies(title: _movieTitle.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CupertinoTextField(
                      controller: _movieTitle,
                      decoration: BoxDecoration(
                          border: Border.all(color: CupertinoColors.systemGrey3),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      padding: EdgeInsets.all(12),
                      placeholder: 'Movie title',
                    ))),
            Padding(
                padding: EdgeInsets.all(8),
                child: CupertinoButton.filled(
                    onPressed: () => _searchMovies(context),
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      CupertinoIcons.search,
                      color: CupertinoColors.white,
                      size: 20,
                    )))
          ],
        ),
        Expanded(
          child: FutureBuilder(
              future: _searchMoviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.connectionState == ConnectionState.none) {
                  return Consumer<MovieProvider>(
                      builder: (context, movieProvider, child) => MoviesList(
                            onMovieRefresh: _refreshMoviesList,
                            moviesList: movieProvider.foundMovies,
                            errorMessage: movieProvider.errorMessage,
                            emptyMessage: 'No movies found',
                          ));
                } else {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
              }),
        )
      ],
    );
  }
}
