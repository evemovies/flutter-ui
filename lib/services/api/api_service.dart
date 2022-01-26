import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eve_mobile/models/api_response_model.dart';

final String baseUrl = dotenv.env[bool.fromEnvironment('dart.vm.product') ? 'PROD_API_BASE_URL' : 'API_BASE_URL']!;

class APIService {
  late final Dio _httpClient;
  fss.FlutterSecureStorage _storage = fss.FlutterSecureStorage();

  APIService() {
    _setupHttpClient();
  }

  _setupHttpClient() {
    _httpClient = Dio(BaseOptions(
        baseUrl: baseUrl,
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

  APIServiceResponse _handleHttpError(DioError error) {
    Fluttertoast.showToast(msg: 'Server error, try again later', timeInSecForIosWeb: 5);

    return APIServiceResponse(success: false);
  }

  Future<APIServiceResponse> get(String url) async {
    try {
      var response = await _httpClient.get(url);
      var responseBody = APIServiceResponse.fromJson(response.data);

      return responseBody;
    } on DioError catch (e) {
      return _handleHttpError(e);
    }
  }

  Future<APIServiceResponse> post(String url, {dynamic data}) async {
    try {
      var response = await _httpClient.post(url, data: data);
      var responseBody = APIServiceResponse.fromJson(response.data);

      return responseBody;
    } on DioError catch (e) {
      return _handleHttpError(e);
    }
  }

  Future<APIServiceResponse> put(String url, {dynamic data}) async {
    try {
      var response = await _httpClient.put(url, data: data);
      var responseBody = APIServiceResponse.fromJson(response.data);

      return responseBody;
    } on DioError catch (e) {
      return _handleHttpError(e);
    }
  }
}
