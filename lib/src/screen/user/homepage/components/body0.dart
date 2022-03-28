import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body0 extends StatefulWidget {
  final int? currentPosition;
  final Function(int)? changePage;
  const Body0({
    Key? key,
    this.currentPosition,
    this.changePage,
  }) : super(key: key);

  @override
  _Body0State createState() => _Body0State();
}

class _Body0State extends State<Body0> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: primaryGradient),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Body(),
      ),
    );
  }
}