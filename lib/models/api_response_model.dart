class APIServiceResponse {
  final bool success;
  final Map<String, dynamic> data;
  final String error;

  APIServiceResponse({required this.success, this.data = const {}, this.error = ''});

  factory APIServiceResponse.fromJson(Map<String, dynamic> json) {
    return APIServiceResponse(success: json['success'] ?? false, data: json['data'] ?? {}, error: json['error'] ?? '');
  }
}
