import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/models/user_model.dart';
import 'package:eve_mobile/services/api/movie_api_service.dart';

class MovieProvider extends ChangeNotifier {
  MovieProvider(this._user);

  final User _user;
  List<Movie> _movies = [];
  MovieAPIService _movieAPIService = MovieAPIService();

  List<Movie> get movies => UnmodifiableListView(_movies);

  Future searchMovies({required String title, int? year}) async {
    _movies = await _movieAPIService.searchMovies(language: _user.language, title: title, year: year);

    notifyListeners();
  }

  void setActiveMoviesList({required List<Movie> movies}) {
    _movies = movies;

    notifyListeners();
  }

  // TODO store movies as a map to find movie by id faster
  Movie getMovie(String id) {
    var movie = _movies.where((m) => m.id == id).first;

    return movie;
  }
}
