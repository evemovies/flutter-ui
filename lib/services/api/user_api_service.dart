import 'package:eve_mobile/services/api/api_service.dart';
import 'package:eve_mobile/models/user_model.dart';
import 'package:eve_mobile/models/movie_model.dart';

class UserAPIService {
  final _apiService = APIService();

  Future<User?> getUser(String userId) async {
    var response = await _apiService.get('/api/v1/users/' + userId);

    if (response.success == true) {
      var user = User.fromJson(response.data);

      return user;
    }
  }

  Future addMovie({required String userId, required Movie movie}) async {
    var response = await _apiService.post('/api/v1/users/$userId/add-movie', data: movie.toJson());

    if (response.success == true) {
      return User.fromJson(response.data);
    } else {
      return response.error;
    }
  }

  Future<User?> removeMovie({required String userId, required String movieId}) async {
    var response = await _apiService.post('/api/v1/users/$userId/remove-movie', data: {'id': movieId});

    if (response.success == true) {
      return User.fromJson(response.data);
    }
  }
}
