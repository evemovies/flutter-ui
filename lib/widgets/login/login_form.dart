import 'package:flutter/cupertino.dart';

class LoginForm extends StatefulWidget {
  final Function(String) onOtpCodeRequested;
  final Function(String userId, String otpCode) onLoginAttempt;
  final bool userIdAccepted;
  final String errorMessage;

  const LoginForm(
      {Key? key,
      required this.onOtpCodeRequested,
      required this.onLoginAttempt,
      required this.userIdAccepted,
      this.errorMessage = ''})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _userIdController = TextEditingController(text: '');
  TextEditingController _otpCodeController = TextEditingController(text: '');

  List<Widget> _buildLoginForm() {
    List<Widget> children = [
      Container(
        width: 200,
        child: CupertinoTextField(
          controller: _userIdController,
          decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.systemGrey3),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          placeholder: 'User ID',
        ),
      )
    ];

    if (widget.userIdAccepted) {
      children.addAll([
        SizedBox(height: 10),
        Container(
          width: 200,
          child: CupertinoTextField(
            controller: _otpCodeController,
            decoration: BoxDecoration(
                border: Border.all(color: CupertinoColors.systemGrey3),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            placeholder: 'Code',
            placeholderStyle: TextStyle(color: CupertinoColors.lightBackgroundGray),
          ),
        )
      ]);
    }

    children.add(SizedBox(height: 30));

    if (widget.userIdAccepted) {
      children.add(CupertinoButton.filled(
          child: Text(
            'Login',
            style: TextStyle(color: CupertinoColors.white),
          ),
          onPressed: () => widget.onLoginAttempt(_userIdController.text, _otpCodeController.text)));
    } else {
      children.add(CupertinoButton.filled(
          child: Text('Request code', style: TextStyle(color: CupertinoColors.white)),
          onPressed: () => widget.onOtpCodeRequested(_userIdController.text)));
    }

    return children;
  }

  Widget _renderErrorMessage() {
    if (widget.errorMessage.length == 0) return Container();

    return Column(children: [
      Text(
        'An error has occurred: ${widget.errorMessage}',
        style: TextStyle(color: CupertinoColors.systemRed),
      ),
      SizedBox(
        height: 30,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_renderErrorMessage(), ..._buildLoginForm()],
      ),
    );
  }
}
