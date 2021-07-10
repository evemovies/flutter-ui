import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;
import 'package:dio/dio.dart';
import 'package:eve_mobile/models/api_response_model.dart';

const BASE_URL = 'http://127.0.0.1:3000';

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

  Future<APIServiceResponse> put(String url, {dynamic data}) async {
    var response = await _httpClient.put(url, data: data);
    var responseBody = APIServiceResponse.fromJson(response.data);

    return responseBody;
  }
}
