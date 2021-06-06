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
