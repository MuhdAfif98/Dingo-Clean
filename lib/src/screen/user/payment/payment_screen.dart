import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/payment/components/body.dart';
import 'package:dingo_clean/src/screen/user/receipt/receipt_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  static const routeName = '/payment';
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ThemeAppBar(
        "Payment Option",
        color: Colors.transparent,
        primaryBg: false,
      ),
      body: const Body(),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: DefaultButton(
            title: "Pay Now",
            press: () {
              Navigator.restorablePushNamed(context, ReceiptScreen.routeName);
            },
          )),
    );
  }
}
