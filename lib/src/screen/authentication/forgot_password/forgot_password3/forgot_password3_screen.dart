import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/authentication/forgot_password/forgot_password3/components/body.dart';
import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword3Screen extends StatefulWidget {
  const ForgotPassword3Screen({Key? key}) : super(key: key);
  static const routeName = "/forgotPassword3";

  @override
  _ForgotPassword3ScreenState createState() => _ForgotPassword3ScreenState();
}

class _ForgotPassword3ScreenState extends State<ForgotPassword3Screen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const ThemeAppBar(
          "Reset Password",
          previous: false,
          primaryBg: false,
        ),
        body: const Body(),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: DefaultButton(
              title: "Update Password",
              color: secondaryColor,
              press: () {
                Navigator.restorablePushNamedAndRemoveUntil(context,
                    SignInScreen.routeName, (Route<dynamic> route) => false);
              }),
        ),
      ),
    );
  }
}
