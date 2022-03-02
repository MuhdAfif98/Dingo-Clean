import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/authentication/forgot_password/forgot_password2/forgot_password2_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ScrollPhysics _physics = const BouncingScrollPhysics();
  TextEditingController emailEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        physics: _physics,
        child: Column(
          children: [
            Text(
              "Forgot Password",
              style: textStyleHeaderBold(),
            ),
            const SizedBox(height: 50),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                          ? null
                          : "Enter correct email";
                    },
                    controller: emailEditingController,
                    decoration: textFieldInputDecoration(
                        "Ex: dingo@gmail.com",
                        "Email",
                        const Icon(
                          Iconsax.sms,
                          color: primaryColor,
                        )),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "We will send you a code to your registered email address to reset your new password",
                    style: textStyleNormal(Colors.black, fontsize: 12),
                  ),
                  const SizedBox(height: 30),
                  DefaultButton(
                    title: "Send Code",
                    press: () {
                      // Call API
                      Navigator.restorablePushNamed(
                          context, ForgotPassword2Screen.routeName);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration textFieldInputDecoration(
      String hintText, String labelText, Widget icon) {
    return InputDecoration(
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
        hintText: hintText,
        labelText: labelText,
        labelStyle: textStyleMedium(),
        prefixIcon: icon);
  }
}
