import 'package:dingo_clean/src/screen/authentication/forgot_password/forgot_password2/components/body.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword2Screen extends StatefulWidget {
  const ForgotPassword2Screen({Key? key}) : super(key: key);
  static const routeName = '/forgotPassword2';

  @override
  _ForgotPassword2ScreenState createState() => _ForgotPassword2ScreenState();
}

class _ForgotPassword2ScreenState extends State<ForgotPassword2Screen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "",
        previous: false,
      ),
      body: Body(),
    );
  }
}
