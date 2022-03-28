import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/booking_1/components/body.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/material.dart';

class Booking2Screen extends StatefulWidget {
  const Booking2Screen({Key? key}) : super(key: key);
  static const routeName = '/booking2';

  @override
  State<Booking2Screen> createState() => _Booking2ScreenScreenState();
}

class _Booking2ScreenScreenState extends State<Booking2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ThemeAppBar(
        "Booking 2",
        color: Colors.transparent,
      ),
      body: const Body(),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: DefaultButton(
            title: "Checkout",
            press: () {},
          )),
    );
  }
}
