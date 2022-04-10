import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/admin/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/screen/authentication/forgot_password/forgot_password1/forgot_password1_screen.dart';
import 'package:dingo_clean/src/screen/authentication/sign_up/sign_up_screen.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/homepage_screen.dart';
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
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
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
                  "Sign in to continue",
                  style: textStyleNormal(textGray),
                ),
                const SizedBox(height: 30),
                TextFormField(
                
                  style: textStyleNormal(secondaryColor),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.message),
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
                      hintText: "Email"),
                ),
                const SizedBox(height: 20),
                TextFormField(
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
                    Navigator.restorablePushNamed(
                        context, HomepageScreen.routeName);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: textStyleNormal(Colors.black),
                        ),
                        const SizedBox(width: 5),
                        ScaleTap(
                          onPressed: () {
                            Navigator.restorablePushNamed(context, SignUpPageScreen.routeName);
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ScaleTap(
                  onPressed: () {Navigator.restorablePushNamed(context, HomepageAdminScreen.routeName);},
                  child: Text(
                    "Go to Admin Page",
                    style: textStyleBold(primaryColor, 14),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
