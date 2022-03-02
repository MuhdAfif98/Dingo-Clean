import 'package:dingo_clean/src/screen/authentication/forgot_password/forgot_password1/components/body.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword1Screen extends StatefulWidget {
  const ForgotPassword1Screen({Key? key}) : super(key: key);

  static const routeName = '/forgotPassword1';

  @override
  _ForgotPassword1ScreenState createState() => _ForgotPassword1ScreenState();
}

class _ForgotPassword1ScreenState extends State<ForgotPassword1Screen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: const ThemeAppBar(
        "",
        primaryBg: false,
      ),
      body: const Body(),
    );
  }
}
