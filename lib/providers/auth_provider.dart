import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:eve_mobile/services/api/api_service.dart' show APIServiceResponse;
import 'package:eve_mobile/services/api/auth_api_service.dart';

class AuthProvider extends ChangeNotifier {
  FlutterSecureStorage _storage = FlutterSecureStorage();
  AuthAPIService _authAPIService = AuthAPIService();

  Future<bool> checkExistingToken() async {
    // await _storage.deleteAll();
    var response = await _authAPIService.checkExistingToken();

    return response.success;
  }

  Future<APIServiceResponse> login({required String userId, required String code}) async {
    var response = await _authAPIService.login(userId: userId, code: code);

    if (response.success) {
      await _storage.write(key: 'token', value: response.data['token']);
    }

    return response;
  }

  Future<APIServiceResponse> requestOtpCode(String userId) async {
    var response = await _authAPIService.requestOtpCode(userId);

    return response;
  }

  void logout() {
    print('Attempt to logout');
  }
}
