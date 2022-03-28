import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration("Name"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration("Contact Number"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration("Address"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration("City"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration("State"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration("Postcode"),
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
