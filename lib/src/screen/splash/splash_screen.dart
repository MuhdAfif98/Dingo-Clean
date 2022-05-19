import 'dart:async';

import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = "/splashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushNamed(context, SignInScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              'assets/images/Dingo-Clean.png',
              height: 650,
              width: 650,
            ),
            const SpinKitChasingDots(
              color: Colors.blueAccent,
              size: 50,
              duration: Duration(milliseconds: 4000),
            )
          ],
        ),
      ),
    );
  }
}
