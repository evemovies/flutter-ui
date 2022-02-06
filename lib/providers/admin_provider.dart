import 'package:eve_mobile/models/admin_stats_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/services/api/admin_api_service.dart';

class AdminProvider extends ChangeNotifier {
  AdminAPIService _adminAPIService = AdminAPIService();
  AdminStats? _stats;
  String _errorMessage = '';

  AdminStats? get stats => _stats;
  String get errorMessage => _errorMessage;

  Future getStats() async {
    var result = await _adminAPIService.getStats();

    if (result is AdminStats) {
      _stats = result;
    } else {
      _errorMessage = result;
    }

    notifyListeners();
  }
}
