import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/admin/user_booking/components/body.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserBookingScreen extends StatefulWidget {
  const UserBookingScreen({Key? key}) : super(key: key);
  static const routeName = '/bookingHistory';

  @override
  State<UserBookingScreen> createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends State<UserBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "User Booking",
        color: Colors.transparent,
      ),
      body: Body(),
    );
  }
}
