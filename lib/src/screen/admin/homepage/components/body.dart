import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/user/booking_1/booking_1_screen.dart';
import 'package:dingo_clean/src/screen/user/setting/setting_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Initialization of Basic House Cleaning
  double bhsum = 0;
  double bhtotal = 0;

  //Initialization of Deep Cleaning
  double dsum = 0;
  double dtotal = 0;

  //Initialization of Laundry Cleaning
  double lsum = 0;
  double ltotal = 0;

  //Initialization of Green Cleaning
  double gsum = 0;
  double gtotal = 0;

  //Initialization of Sanitization
  double ssum = 0;
  double stotal = 0;

  //Total of all price
  double totalServiceSum = 0;
  double totalServicePrice = 0;

  //Get total price of Basic House Cleaning
  void getBasicHouseCleaning() {
    FirebaseFirestore.instance
        .collection('bookingAdmin')
        .where("Service type", isEqualTo: "Basic House Cleaning")
        .get()
        .then(
      (querySnapshot) {
        for (var result in querySnapshot.docs) {
          bhsum = bhsum + result.data()['Total Price'];
        }
        setState(() {
          bhtotal = bhsum;
        });
      },
    );
  }

  //Get total price of Deep Cleaning
  void getDeepCleaning() {
    FirebaseFirestore.instance
        .collection('bookingAdmin')
        .where("Service type", isEqualTo: "Deep Cleaning")
        .get()
        .then(
      (querySnapshot) {
        for (var result in querySnapshot.docs) {
          dsum = dsum + result.data()['Total Price'];
        }
        setState(() {
          dtotal = dsum;
        });
      },
    );
  }

  //Get total price of Laundry Cleaning
  void getLaundryCleaning() {
    FirebaseFirestore.instance
        .collection('bookingAdmin')
        .where("Service type", isEqualTo: "Laundry Cleaning")
        .get()
        .then(
      (querySnapshot) {
        for (var result in querySnapshot.docs) {
          lsum = lsum + result.data()['Total Price'];
        }
        setState(() {
          ltotal = lsum;
        });
      },
    );
  }

  //Get total price of Green Cleaning
  void getGreenCleaning() {
    FirebaseFirestore.instance
        .collection('bookingAdmin')
        .where("Service type", isEqualTo: "Green Cleaning")
        .get()
        .then(
      (querySnapshot) {
        for (var result in querySnapshot.docs) {
          gsum = gsum + result.data()['Total Price'];
        }
        setState(() {
          gtotal = gsum;
        });
      },
    );
  }

  //Get total price of Sanitization
  void getSanitization() {
    FirebaseFirestore.instance
        .collection('bookingAdmin')
        .where("Service type", isEqualTo: "Sanitization")
        .get()
        .then(
      (querySnapshot) {
        for (var result in querySnapshot.docs) {
          ssum = ssum + result.data()['Total Price'];
        }
        setState(() {
          stotal = ssum;
        });
      },
    );
  }

  @override
  void initState() {
    getBasicHouseCleaning();
    getDeepCleaning();
    getLaundryCleaning();
    getGreenCleaning();
    getSanitization();
    super.initState();
  }

  static const shadowColor = Color(0xFFCCCCCC);
  static const dataList = [
    _BarData(Color(0xFFecb206), 18, 18),
    _BarData(Color(0xFFa8bd1a), 17, 8),
    _BarData(Color(0xFF17987b), 10, 15),
    _BarData(Color(0xFFb87d46), 2.5, 5),
    _BarData(Color(0xFF295ab5), 2, 2.5),
    _BarData(Color(0xFFea0107), 2, 2),
  ];

  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: _BodyState.shadowColor,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
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
            Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.4,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceBetween,
                          borderData: FlBorderData(
                            show: true,
                            border: const Border.symmetric(
                              horizontal: BorderSide(
                                color: Color(0xFFececec),
                              ),
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            leftTitles: AxisTitles(
                              drawBehindEverything: true,
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF606060),
                                    ),
                                    textAlign: TextAlign.left,
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 36,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: _IconWidget(
                                      color: _BodyState.dataList[index].color,
                                      isSelected: touchedGroupIndex == index,
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(),
                            topTitles: AxisTitles(),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: const Color(0xFFececec),
                              dashArray: null,
                              strokeWidth: 1,
                            ),
                          ),
                          barGroups:
                              _BodyState.dataList.asMap().entries.map((e) {
                            final index = e.key;
                            final data = e.value;
                            return generateBarGroup(index, data.color,
                                data.value, data.shadowValue);
                          }).toList(),
                          maxY: 20,
                          barTouchData: BarTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.transparent,
                                tooltipMargin: 0,
                                getTooltipItem: (
                                  BarChartGroupData group,
                                  int groupIndex,
                                  BarChartRodData rod,
                                  int rodIndex,
                                ) {
                                  return BarTooltipItem(
                                    rod.toY.toString(),
                                    TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: rod.color!,
                                        fontSize: 18,
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black26,
                                            blurRadius: 12,
                                          )
                                        ]),
                                  );
                                }),
                            touchCallback: (event, response) {
                              if (event.isInterestedForInteractions &&
                                  response != null &&
                                  response.spot != null) {
                                setState(() {
                                  touchedGroupIndex =
                                      response.spot!.touchedBarGroupIndex;
                                });
                              } else {
                                setState(() {
                                  touchedGroupIndex = -1;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
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
      MaterialPageRoute(builder: (context) => SignInScreen()),
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
