import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/theme_provider.dart';
import 'package:eve_mobile/providers/auth_provider.dart';
import 'package:eve_mobile/views/dashboard_view.dart';
import 'package:eve_mobile/widgets/login/login_form.dart';

class LoginView extends StatefulWidget {
  static const routeName = '/';

  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _userIdAccepted = false;
  bool _autoLoginInProgress = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();

    Provider.of<ThemeProvider>(context, listen: false).initTheme();
    _attemptToAutoLogin();
  }

  void _attemptToAutoLogin() async {
    var isTokenValid = await Provider.of<AuthProvider>(context, listen: false).checkExistingToken();

    if (isTokenValid) {
      Navigator.pushNamedAndRemoveUntil(context, DashboardView.routeName, (r) => false);
    } else {
      setState(() {
        _autoLoginInProgress = false;
      });
    }
  }

  void _requestOtpCode(String userId) async {
    var result = await Provider.of<AuthProvider>(context, listen: false).requestOtpCode(userId);

    if (result.success) {
      setState(() {
        _errorMessage = '';
        _userIdAccepted = true;
      });
    } else {
      setState(() {
        _errorMessage = result.error;
        _userIdAccepted = false;
      });
    }
  }

  void _login(String userId, String code) async {
    var result = await Provider.of<AuthProvider>(context, listen: false).login(userId: userId, code: code);

    if (result.success) {
      Navigator.pushNamedAndRemoveUntil(context, DashboardView.routeName, (r) => false);
    } else {
      setState(() {
        _errorMessage = result.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_autoLoginInProgress) return CupertinoPageScaffold(child: Center(child: CupertinoActivityIndicator()));

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Login',
        ),
        leading: Container(),
      ),
      child: (SafeArea(
        child: LoginForm(
          userIdAccepted: _userIdAccepted,
          errorMessage: _errorMessage,
          onOtpCodeRequested: _requestOtpCode,
          onLoginAttempt: _login,
        ),
      )),
    );
  }
}
