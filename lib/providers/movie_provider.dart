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
  MovieAPIService _movieAPIService = MovieAPIService();

  List<Movie> get foundMovies => UnmodifiableListView(_foundMovies);
  List<Movie> get userMovies => UnmodifiableListView(_userMovies);
  List<Movie> get allMovies => UnmodifiableListView([..._foundMovies, ..._userMovies]);

  Future searchMovies({required String title, int? year}) async {
    _foundMovies = await _movieAPIService.searchMovies(language: _user.language, title: title, year: year);

    notifyListeners();
  }

  void setUserMoviesList({required List<Movie> movies}) {
    _userMovies = movies;

    notifyListeners();
  }

  // TODO store movies as a map to find movie by id faster
  Movie getMovie(String id) {
    var movie = allMovies.firstWhere((m) => m.id == id);

    return movie;
  }
}
