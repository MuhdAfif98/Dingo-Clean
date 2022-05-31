import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/screen/admin/financial_service/financial_screen.dart';
import 'package:dingo_clean/src/screen/admin/sign_in_admin/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/admin/user_booking/booking_history_screen.dart';
import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/user/booking_1/booking_1_screen.dart';
import 'package:dingo_clean/src/screen/user/setting/setting_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:number_animation/number_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double totalGrossProfit = 0;
  double totalAllProfit = 0;

  void getTotalProfit() {
    FirebaseFirestore.instance.collection('bookingAdmin').get().then(
      (querySnapshot) {
        for (var result in querySnapshot.docs) {
          totalAllProfit = totalAllProfit + result.data()['Total Price'];
        }
        setState(() {
          totalGrossProfit = totalAllProfit;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getTotalProfit();
  }

  int touchedGroupIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      "https://imgix.ranker.com/user_node_img/50126/1002515936/original/1002515936-photo-u2?auto=format&q=60&fit=crop&fm=pjpg&dpr=2&w=375",
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: textStyleNormal(Colors.white),
                        ),
                        Text(
                          "ADMIN",
                          style: textStyleBold(Colors.white, 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  ScaleTap(
                    onPressed: () {
                      signOut();
                    },
                    child: const Icon(
                      Iconsax.logout,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [shadowList()],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text("Total Gross Profit"),
                    SizedBox(
                      height: 10,
                    ),
                    NumberAnimation(
                      textAlign: TextAlign.center,
                      decimalPoint: 0,
                      before: "RM ",
                      start: 0, // default is 0, can remove
                      end: totalGrossProfit.toInt(),
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                      duration: Duration(milliseconds: 1000),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Quick Action",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 15,
            ),
            ScaleTap(
              onPressed: () {
                Navigator.restorablePushNamed(
                    context, FinancialServiceScreen.routeName);
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/clean1_1.png"),
                      alignment: Alignment.centerRight,
                      filterQuality: FilterQuality.high,
                      scale: 1.5),
                  boxShadow: [shadowList()],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Text(
                      "Financial Status",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 119, 216),
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )),
              ),
            ),
            SizedBox(height: 15,),
            ScaleTap(
              onPressed: () {
                Navigator.restorablePushNamed(
                    context, UserBookingScreen.routeName);
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/clean1_1.png"),
                      alignment: Alignment.centerRight,
                      filterQuality: FilterQuality.high,
                      scale: 1.5),
                  boxShadow: [shadowList()],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Text(
                      "User Booking",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 119, 216),
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxShadow shadowList() {
    return BoxShadow(
      blurRadius: 7,
      spreadRadius: 0,
      offset: const Offset(4, 4),
      color: Colors.black.withOpacity(0.2),
    );
  }

  Future signOut() async {
    await _auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInAdminScreen()),
    );
  }
}

class _BarData {
  final Color color;
  final double value;
  final double shadowValue;

  const _BarData(this.color, this.value, this.shadowValue);
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  final Color color;
  final bool isSelected;

  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>;
  }
}
