import 'package:eve_mobile/services/api/api_service.dart';
import 'package:eve_mobile/models/user_model.dart';
import 'package:eve_mobile/models/movie_model.dart';

class UserAPIService {
  final _apiService = APIService();

  Future<User> getUser() async {
    var response = await _apiService.get('/api/v1/user');

    return User.fromJson(response.data);
  }

  Future<User> addMovie(Movie movie) async {
    var response = await _apiService.put('/api/v1/user/add-movie', data: movie.toJson());

    return User.fromJson(response.data);
  }

  Future<User> removeMovie(String movieId) async {
    var response = await _apiService.put('/api/v1/user/remove-movie', data: {'id': movieId});

    return User.fromJson(response.data);
  }
}
