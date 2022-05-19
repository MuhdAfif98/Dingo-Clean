import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/booking_1/components/body.dart';
import 'package:dingo_clean/src/screen/user/booking_2/booking_2_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/material.dart';

class Booking1Screen extends StatefulWidget {
  const Booking1Screen({Key? key}) : super(key: key);
  static const routeName = '/booking1';

  @override
  State<Booking1Screen> createState() => _Booking1ScreenScreenState();
}

class _Booking1ScreenScreenState extends State<Booking1Screen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "Booking 1",
        color: Colors.transparent,
      ),
      body: Body(),

    );
  }
}
