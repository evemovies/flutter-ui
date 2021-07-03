import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/user_model.dart';
import 'package:eve_mobile/services/api/user_api_service.dart';

User _emptyUser = User(
    id: '',
    created: 0,
    username: '',
    name: '',
    lastActivity: 0,
    totalMovies: 0,
    language: '',
    observableMovies: []);

class UserProvider extends ChangeNotifier {
  UserAPIService _userAPIService = UserAPIService();
  User _user = _emptyUser;

  User get user => _user;

  Future getUser() async {
    _user = await _userAPIService.getUser();

    notifyListeners();
  }
}
