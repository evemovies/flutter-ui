import 'dart:convert';
import 'package:http/http.dart' as http;

const BASE_URL = 'localhost:3000';

class APIServiceResponse {
  final bool success;
  final dynamic data;
  final String error;

  var client = http.Client();

  APIServiceResponse({this.success, this.data, this.error});

  APIServiceResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        data = json['data'],
        error = json['error'];
}

class APIService {
  // Future<APIServiceResponse> login(String code) async {
  // var response = http.post(url)
  // Future.delayed(Duration(seconds: 3));
  //
  // User user = User(id: 123, username: 'th1rt3nth');
  //
  // var response = AuthServiceResponse(success: true, token: '123456789', user: user);
  //
  // return response;
  // }

  Future<bool> checkToken(String token) async {
    Future.delayed(Duration(seconds: 3));

    return true;
  }

  void logout() {
    print('Sending logout HTTP request');
  }

  Future<APIServiceResponse> requestOtpCode(String userId) async {
    var body = json.encode({'user_id': userId});

    var response = await http.post(Uri.http(BASE_URL, '/api/v1/request-otp-code'),
        headers: {'Content-Type': 'application/json'}, body: body);

    var responseBody = APIServiceResponse.fromJson(json.decode(response.body));

    return responseBody;
  }

  Future<APIServiceResponse> login({String userId, String code}) async {
    var body = json.encode({'_id': userId, 'OTPCode': code});

    var response = await http.post(Uri.http(BASE_URL, '/api/v1/login'),
        headers: {'Content-Type': 'application/json'}, body: body);

    var responseBody = APIServiceResponse.fromJson(json.decode(response.body));

    return responseBody;
  }

  // Future<APIServiceResponse> ping() async {
  Future<APIServiceResponse> ping(String token) async {
    var response = await http.get(Uri.http(BASE_URL, '/api/v1/general/ping'),
        headers: {'Authorization': 'Bearer $token'});

    var responseBody = APIServiceResponse.fromJson(json.decode(response.body));

    return responseBody;

    // return responseBody;
  }

  // void checkSession(String session) {
  //   print('Sending checkSession HTTP request with session $session');
  // }
}
