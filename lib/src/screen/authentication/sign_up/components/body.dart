import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String text = "dsdsd";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imagePlaceHolder(),
            const SizedBox(height: 30),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration("Name"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration("Email"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: passwordInputDecoration("New Password"),
              obscureText: true,
              obscuringCharacter: "*",
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: passwordInputDecoration("Confirm Password"),
              obscureText: true,
              obscuringCharacter: "*",
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration defaultInputDecoration(String? hintText) {
    return InputDecoration(
        counterText: "",
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
        hintText: hintText);
  }

  InputDecoration passwordInputDecoration(String? hintText) {
    return InputDecoration(
        suffixIcon: const Icon(
          Iconsax.eye4,
          color: primaryColor,
        ),
        counterText: "",
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
        hintText: hintText);
  }

  Widget imagePlaceHolder() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FDottedLine(
            width: double.infinity,
            color: textGray,
            corner: FDottedLineCorner.all(15),
            space: 13,
            strokeWidth: 2,
            dottedLength: 10,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 40,
                  ),
                  child: Icon(
                    Iconsax.user,
                    color: textGray,
                    size: 54,
                  ),
                ),
                Text(
                  "Upload Your Selfie",
                  style: textStyleMedium(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
