import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/auth_provider.dart';
import 'package:eve_mobile/views/dashboard_view.dart';

class LoginView extends StatefulWidget {
  static const routeName = '/';

  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _otpCodeRequested = false;
  bool _autoLoginInProgress = true;
  String _errorMessage = '';
  TextEditingController _userIdController = TextEditingController(text: '');
  TextEditingController _otpCodeController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

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

  void _requestOtpCode() async {
    var userId = _userIdController.text;
    var result = await Provider.of<AuthProvider>(context, listen: false).requestOtpCode(userId);

    if (result.success) {
      setState(() {
        _errorMessage = '';
        _otpCodeRequested = true;
      });
    } else {
      setState(() {
        _errorMessage = result.error;
        _otpCodeRequested = false;
        _userIdController.text = '';
      });
    }
  }

  void _login() async {
    var userId = _userIdController.text;
    var code = _otpCodeController.text;

    var result = await Provider.of<AuthProvider>(context, listen: false).login(userId: userId, code: code);

    if (result.success) {
      Navigator.pushNamedAndRemoveUntil(context, DashboardView.routeName, (r) => false);
    } else {
      setState(() {
        _errorMessage = result.error;
        _otpCodeRequested = false;
        _otpCodeController.text = '';
      });
    }
  }

  List<Widget> _buildLoginForm() {
    List<Widget> children = [
      Container(
        width: 200,
        child: CupertinoTextField(
          controller: _userIdController,
          placeholder: 'User ID',
        ),
      ),
    ];

    if (_otpCodeRequested) {
      // Render OTP code input
      children.addAll([
        SizedBox(height: 10),
        Container(
          width: 200,
          child: CupertinoTextField(
            controller: _otpCodeController,
            placeholder: 'Code',
          ),
        )
      ]);
    }

    children.add(SizedBox(
      height: 30,
    ));

    if (_otpCodeRequested) {
      children.add(CupertinoButton.filled(child: Text('Login'), onPressed: _login));
    } else {
      children.add(CupertinoButton.filled(child: Text('Request code'), onPressed: _requestOtpCode));
    }

    children.add(Spacer());

    return children;
  }

  Widget _renderErrorMessage() {
    if (_errorMessage.length == 0) return Container();

    return Text(
      'An error has occurred: $_errorMessage',
      style: TextStyle(color: CupertinoColors.systemRed),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this._autoLoginInProgress) return CupertinoPageScaffold(child: Center(child: CupertinoActivityIndicator()));

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Login'),
        leading: new Container(),
      ),
      child: SafeArea(
          child: Center(
              child: Column(
        children: [Spacer(), _renderErrorMessage(), ..._buildLoginForm()],
      ))),
    );
  }
}
