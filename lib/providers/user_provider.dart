import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/user_model.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/services/api/user_api_service.dart';

User _emptyUser = User(
    id: '', created: 0, username: '', name: '', lastActivity: 0, totalMovies: 0, language: '', observableMovies: []);

class UserProvider extends ChangeNotifier {
  UserAPIService _userAPIService = UserAPIService();
  User _user = _emptyUser;

  User get user => _user;

  Future getUser() async {
    _user = await _userAPIService.getUser();

    notifyListeners();
  }

  Future addMovieToCollection(Movie movie) async {
    var updatedUser = await _userAPIService.addMovie(movie);

    _user = updatedUser;

    notifyListeners();
  }

  Future removeMovieFromCollection(String movieId) async {
    var updatedUser = await _userAPIService.removeMovie(movieId);

    _user = updatedUser;

    notifyListeners();
  }

  Movie? getUserMovie(String id) {
    var movie = _user.observableMovies.firstWhereOrNull((m) => m.id == id);

    return movie;
  }
}
