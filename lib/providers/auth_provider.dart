import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:eve_mobile/services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  FlutterSecureStorage _storage = new FlutterSecureStorage();
  APIService _apiService = new APIService();

  Future<APIServiceResponse> checkExistingToken() async {
    var token = await _storage.read(key: 'token');
    var response = await _apiService.ping(token);

    return response;
  }

  Future<APIServiceResponse> login({String userId, String code}) async {
    var response = await _apiService.login(userId: userId, code: code);

    if (response.success) {
      await _storage.write(key: 'token', value: response.data['token']);
    }

    return response;
  }

  Future<APIServiceResponse> requestOtpCode(String userId) async {
    var response = await _apiService.requestOtpCode(userId);

    return response;
  }

  void logout() {
    print('Attempt to logout');
  }
}
