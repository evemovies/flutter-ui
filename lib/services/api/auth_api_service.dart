import 'dart:convert';
import 'package:eve_mobile/services/api/api_service.dart';
import 'package:eve_mobile/models/api_response_model.dart';

class AuthAPIService {
  final _apiService = APIService();

  Future<APIServiceResponse> requestOtpCode(String userId) async {
    var data = json.encode({'id': userId});
    var response = await _apiService.post('/api/v1/auth/request-otp-code', data: data);

    return response;
  }

  Future<APIServiceResponse> login({required String userId, required String code}) async {
    var data = json.encode({'id': userId, 'OTPCode': code});
    var response = await _apiService.post('/api/v1/auth/login', data: data);

    return response;
  }

  Future logout() async {
    await _apiService.post('/api/v1/logout', data: {});
  }

  Future<APIServiceResponse> checkExistingToken() async {
    var response = await _apiService.get('/api/v1/auth/access');

    return response;
  }
}
