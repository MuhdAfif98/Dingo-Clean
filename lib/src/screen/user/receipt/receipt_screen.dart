import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/screen/user/receipt/components/body.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);
  static const routeName = '/receipt';
  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ThemeAppBar(
        "Receipt",
        color: Colors.transparent,
        primaryBg: false,
      ),
      body: const Body(),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: DefaultButton(
            title: "Return Home",
            press: () {
              Navigator.restorablePushNamed(context, HomepageScreen.routeName);
            },
          )),
    );
  }
}
