import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:eve_mobile/models/user_model.dart';
import 'package:eve_mobile/models/movie_model.dart';
import 'package:eve_mobile/services/api/user_api_service.dart';

User _emptyUser = User(
    id: '', created: 0, username: '', name: '', lastActivity: 0, totalMovies: 0, language: '', observableMovies: []);

class UserProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final UserAPIService _userAPIService = UserAPIService();
  User _user = _emptyUser;

  User get user => _user;

  Future getUser() async {
    var userId = await _storage.read(key: 'user_id');

    if (userId != null) {
      var receivedUser = await _userAPIService.getUser(userId);

      if (receivedUser != null) {
        _user = receivedUser;
        notifyListeners();
      }
    }
  }

  Future addMovieToCollection(Movie movie) async {
    var responseResult = await _userAPIService.addMovie(userId: user.id, movie: movie);

    if (responseResult is User) {
      _user = responseResult;

      notifyListeners();
    } else {
      return responseResult;
    }
  }

  Future removeMovieFromCollection(String movieId) async {
    var updatedUser = await _userAPIService.removeMovie(userId: user.id, movieId: movieId);

    if (updatedUser != null) {
      _user = updatedUser;

      notifyListeners();
    }
  }

  Movie? getUserMovie(String id) {
    var movie = _user.observableMovies.firstWhereOrNull((m) => m.id == id);

    return movie;
  }
}
