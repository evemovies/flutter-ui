import 'package:eve_mobile/widgets/movie/movies_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  void _searchMovies() async {
    setState(() {
      _searchMoviesFuture = Provider.of<MovieProvider>(context, listen: false).searchMovies(title: _movieTitle.text);
    });
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
                      padding: EdgeInsets.all(12),
                      placeholder: 'Movie title',
                    ))),
            Padding(
                padding: EdgeInsets.all(8),
                child: CupertinoButton.filled(
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      CupertinoIcons.search,
                      size: 20,
                    ),
                    onPressed: _searchMovies))
          ],
        ),
        Expanded(
          child: FutureBuilder(
              future: _searchMoviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.connectionState == ConnectionState.none) {
                  return Consumer<MovieProvider>(
                      builder: (context, movieProvider, child) => MoviesList(moviesList: movieProvider.foundMovies));
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
