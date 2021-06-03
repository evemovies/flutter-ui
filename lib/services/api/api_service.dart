import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;
import 'package:dio/dio.dart';

const BASE_URL = 'http://127.0.0.1:3000';

class APIServiceResponse {
  final bool success;
  final Map<String, dynamic> data;
  final String error;

  APIServiceResponse({required this.success, this.data = const {}, this.error = ''});

  APIServiceResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        data = json['data'] ?? {},
        error = json['error'] ?? '';
}

class APIService {
  late final Dio _httpClient;
  fss.FlutterSecureStorage _storage = fss.FlutterSecureStorage();

  APIService() {
    _setupHttpClient();
  }

  _setupHttpClient() {
    _httpClient = Dio(BaseOptions(
        baseUrl: BASE_URL,
        contentType: Headers.jsonContentType,
        validateStatus: (status) {
          return status != null && status < 500;
        }));

    _httpClient.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      var token = await _storage.read(key: 'token');

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      return handler.next(options);
    }));
  }

  void logout() {
    print('Sending logout HTTP request');
  }

  Future<APIServiceResponse> get(String url) async {
    var response = await _httpClient.get(url);
    var responseBody = APIServiceResponse.fromJson(response.data);

    return responseBody;
  }

  Future<APIServiceResponse> post(String url, {dynamic data}) async {
    var response = await _httpClient.post(url, data: data);
    var responseBody = APIServiceResponse.fromJson(response.data);

    return responseBody;
  }
}
