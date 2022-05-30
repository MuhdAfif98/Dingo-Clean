import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/authentication/sign_up/components/body.dart';
import 'package:dingo_clean/src/screen/authentication/sign_up2/sign_up2_screen.dart';
import 'package:dingo_clean/src/screen/authentication/verification_code/verification_code_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPageScreen extends StatefulWidget {
  const SignUpPageScreen({Key? key}) : super(key: key);
  static const routeName = '/signUpPage';

  @override
  _SignUpPageScreenState createState() => _SignUpPageScreenState();
}

class _SignUpPageScreenState extends State<SignUpPageScreen> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "Sign Up",
        color: Colors.transparent,
        onBackPressed: (){
          Navigator.restorablePushNamed(context, SignInScreen.routeName);
        },
      ),
      body: Body(),
    );
  }
}
