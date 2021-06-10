import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/services/api/movies_api_service.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesAPIService _moviesAPIService = MoviesAPIService();
  List<Movie> _movies = [];

  UnmodifiableListView<Movie> get movies => UnmodifiableListView(_movies);

  Future getMovies() async {
    _movies = await _moviesAPIService.getMovies();

    notifyListeners();
  }

  // TODO store movies as a map to find movie by id faster
  Movie getMovieById(String id) {
    var movie = movies.where((m) => m.id == id).first;

    return movie;
  }
}
