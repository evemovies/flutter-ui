import 'package:eve_mobile/services/api/api_service.dart';
import 'package:eve_mobile/models/user_model.dart';

class UserAPIService {
  final _apiService = APIService();

  Future<User> getUser() async {
    var response = await _apiService.get('/api/v1/user');

    return User.fromJson(response.data);
  }
}
