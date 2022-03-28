import 'dart:async';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late StreamController<ErrorAnimationType> errorController;
  bool isLoading = false;
  bool hasError = false;
  String loadingText = '';

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                const Icon(
                  Iconsax.security_safe,
                  size: 100,
                  color: primaryColor,
                ),
                const SizedBox(height: 20),
                Text(
                  "Verify Your Email",
                  style: textStyleHeaderBold(),
                ),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Enter the code sent to ",
                    style: textStyleBold(primaryColor, 14),
                    children: [
                      TextSpan(
                        text: secureEmail("mizzat0909@gmail.com"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  pastedTextStyle: textStyleBold(primaryColor, 14),
                  errorAnimationController: errorController,
                  obscureText: false,
                  obscuringCharacter: '*',
                  animationType: AnimationType.scale,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    borderWidth: 1,
                    fieldHeight: 60,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: disabledText,
                    selectedFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  textStyle: const TextStyle(fontSize: 20, height: 1.6),
                  backgroundColor: lightPrimaryColor,
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      hasError = true;
                    });
                  },
                  beforeTextPaste: (text) {
                    if (text != null &&
                        text.trim().length == 6 &&
                        isNumeric(text)) {
                      return true;
                    }
                    return false;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    hasError ? "Invalid OTP Number" : "",
                    style: textStyleNormal(Colors.red),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String secureEmail(String text) {
    int middle = (text.length / 2).ceil();
    int midHalf = (middle / 2).ceil();
    int start = midHalf;

    int end = middle + midHalf;
    int space = end - start;

    String secure = text.replaceRange(start, end, '*' * space);
    return secure;
  }

  bool isNumeric(String text) {
    // ignore: unnecessary_null_comparison
    if (text == null) {
      return false;
    }
    return double.tryParse(text) != null;
  }
}
