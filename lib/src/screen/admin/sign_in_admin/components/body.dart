import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/admin/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/screen/authentication/forgot_password/forgot_password1/forgot_password1_screen.dart';
import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/authentication/sign_up/sign_up_screen.dart';
import 'package:dingo_clean/src/services/auth.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String email = '';
  String password = '';
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 56 + 12,
              left: 30,
              right: 30,
              bottom: 10,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/Dingo-Clean-nobg.png",
                    width: 200,
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: const TextSpan(
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: "D", style: TextStyle(color: primaryColor)),
                          TextSpan(
                              text: "ingo ",
                              style: TextStyle(color: secondaryColor)),
                          TextSpan(
                              text: "C", style: TextStyle(color: primaryColor)),
                          TextSpan(
                              text: "lean",
                              style: TextStyle(color: secondaryColor)),
                        ]),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Administrator",
                    style: textStyleNormal(secondaryColor),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Sign in to continue",
                    style: textStyleNormal(textGray),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    validator: (val) => val!.isEmpty ? "Enter an email" : null,
                    style: textStyleNormal(secondaryColor),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.message),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: primaryColor),
                            gapPadding: 10),
                        contentPadding:
                            const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          gapPadding: 10,
                        ),
                        fillColor: lightPrimaryColor,
                        filled: true,
                        hintStyle: textStyleMedium(),
                        hintText: "Email"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    validator: (val) =>
                        val!.isEmpty ? "Enter the password" : null,
                    style: textStyleNormal(primaryColor),
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.unlock),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: primaryColor),
                          gapPadding: 10),
                      contentPadding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                        gapPadding: 10,
                      ),
                      fillColor: lightPrimaryColor,
                      filled: true,
                      hintStyle: textStyleMedium(),
                      hintText: "Password",
                      suffixIcon: const Icon(
                        Iconsax.eye4,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Forgot Password",
                          style: textStyleNormal(primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.restorablePushNamed(
                                  context, ForgotPassword1Screen.routeName);
                            },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  DefaultButton(
                    title: "Sign In",
                    loadingText: "Sign you in . . .",
                    press: () {
                      Navigator.restorablePushNamed(context, HomepageAdminScreen.routeName);
                      // if (_formKey.currentState!.validate()) {
                      //   signInAdmin();
                      // }
                      // debugPrint(email);
                    },
                  ),
                  const SizedBox(height: 40),
                  ScaleTap(
                    onPressed: () {
                      Navigator.restorablePushNamed(
                          context, SignInScreen.routeName);
                    },
                    child: Text(
                      "Go to User Page ",
                      style: textStyleBold(primaryColor, 14),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInAdmin() async {
    dynamic result = await _auth.loginAdminAccount(
        _emailController.text, _passwordController.text);
    if (result == null) {
      debugPrint('Sign in error. could not be able to login');
    } else {
      _emailController.clear();
      _passwordController.clear();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomepageAdminScreen()));
    }
  }
}
