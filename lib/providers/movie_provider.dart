import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/models/user_model.dart';
import 'package:eve_mobile/services/api/movie_api_service.dart';

class MovieProvider extends ChangeNotifier {
  MovieProvider(this._user);

  final User _user;
  List<Movie> _foundMovies = [];
  List<Movie> _userMovies = [];
  final MovieAPIService _movieAPIService = MovieAPIService();
  String _errorMessage = '';

  List<Movie> get foundMovies => UnmodifiableListView(_foundMovies);
  List<Movie> get userMovies => UnmodifiableListView(_userMovies);
  List<Movie> get _allMovies => UnmodifiableListView([..._foundMovies, ..._userMovies]);
  String get errorMessage => _errorMessage;

  Future searchMovies({required String title, int? year}) async {
    var result = await _movieAPIService.searchMovies(language: _user.language, title: title, year: year);

    if (result is List) {
      _foundMovies = result as List<Movie>;
    } else {
      _errorMessage = result;
    }

    notifyListeners();
  }

  void setUserMoviesList({required List<Movie> movies}) {
    var existingMovieIds = userMovies.map((movie) => movie.id);

    // Keep previous movies as well
    _userMovies = [...userMovies, ...movies.where((movie) => !existingMovieIds.contains(movie.id)).toList()];

    notifyListeners();
  }

  Movie getMovie(String id) {
    var movie = _allMovies.firstWhere((m) => m.id == id);

    return movie;
  }
}
