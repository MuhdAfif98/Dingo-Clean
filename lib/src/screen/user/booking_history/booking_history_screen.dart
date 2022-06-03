import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/booking_history/components/body.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);
  static const routeName = '/bookingHistory';

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "Booking History",
        color: Colors.transparent,
        onBackPressed: (){
          Navigator.restorablePushNamed(context, HomepageScreen.routeName);
        },
      ),
      body: Body(),
    );
  }
}
