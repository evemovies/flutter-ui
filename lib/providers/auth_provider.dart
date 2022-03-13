import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:eve_mobile/services/api/auth_api_service.dart';
import 'package:eve_mobile/models/api_response_model.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final AuthAPIService _authAPIService = AuthAPIService();

  Future<bool> checkExistingToken() async {
    var response = await _authAPIService.checkExistingToken();

    return response.success;
  }

  Future<APIServiceResponse> login({required String userId, required String code}) async {
    var response = await _authAPIService.login(userId: userId, code: code);

    if (response.success) {
      await _storage.write(key: 'token', value: response.data['access_token']);
      await _storage.write(key: 'user_id', value: response.data['user_id']);
    }

    return response;
  }

  Future<APIServiceResponse> requestOtpCode(String userId) async {
    var response = await _authAPIService.requestOtpCode(userId);

    return response;
  }

  Future logout() async {
    await _authAPIService.logout();

    await _storage.deleteAll();
  }
}
