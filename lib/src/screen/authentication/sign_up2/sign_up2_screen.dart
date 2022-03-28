import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/authentication/sign_up2/components/body.dart';
import 'package:dingo_clean/src/screen/authentication/verification_code/verification_code_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp2Screen extends StatefulWidget {
  const SignUp2Screen({ Key? key }) : super(key: key);
  static const routeName = '/signUpPage2';

  @override
  State<SignUp2Screen> createState() => _SignUp2ScreenState();
}

class _SignUp2ScreenState extends State<SignUp2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ThemeAppBar(
        "Sign Up",
        color: Colors.transparent,
      ),
      body: const Body(),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: DefaultButton(
            title: "Register",
            press: () {
              Navigator.restorablePushNamed(
                  context, VerificationCodeScreen.routeName);
            },
          )),
    );
  }
}