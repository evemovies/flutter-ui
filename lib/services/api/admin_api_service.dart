import 'package:eve_mobile/services/api/api_service.dart';
import 'package:eve_mobile/models/admin_stats_model.dart';

class AdminAPIService {
  final _apiService = APIService();

  Future getStats() async {
    var response = await _apiService.get('/api/v1/admin/stats');

    if (response.success) {
      return AdminStats.fromJson(response.data);
    } else {
      return response.error;
    }
  }
}
