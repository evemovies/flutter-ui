import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum ThemeOption { dark, light, system }

class ThemeProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  ThemeOption _theme = ThemeOption.system;

  ThemeOption get theme => _theme;

  Future<void> initTheme() async {
    var savedTheme = await _storage.read(key: 'theme') ?? 'system';

    _theme = ThemeOption.values.byName(savedTheme);

    notifyListeners();
  }

  Future<void> updateTheme(ThemeOption theme) async {
    _theme = theme;
    await _storage.write(key: 'theme', value: theme.toString().split('.').last);

    notifyListeners();
  }
}
