import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        inputText("Old Password"),
        inputText("New Password"),
        inputText("Confirm Password"),
      ],
    );
  }
}

  Widget inputText(String hintText) {
      return Column(
        children: [
          //Input text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              obscureText: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: textStyleNormal(textGray),
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: textGray),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: primaryColor, width: 1),
                ),
              ),
            ),
          )
        ]);
  }
