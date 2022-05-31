import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:number_animation/number_animation.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int touchedIndex = -1;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                color: Colors.white,
                elevation: 5,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 0,
                        sections: showingSections()),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Service Type :"),
          SizedBox(
            height: 15,
          ),
          indicator("assets/images/basic_house_cleaning.png",
              'Basic House Cleaning', bhsum),
          SizedBox(
            height: 10,
          ),
          indicator("assets/images/deep_cleaning.png", 'Deep Cleaning', dsum),
          SizedBox(
            height: 10,
          ),
          indicator(
              "assets/images/laundry_cleaning.png", 'Laundry Cleaning', lsum),
          SizedBox(
            height: 10,
          ),
          indicator("assets/images/green_cleaning.png", 'Green Cleaning', gsum),
          SizedBox(
            height: 10,
          ),
          indicator("assets/images/sanitization.png", 'Sanitization', ssum),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 185, 255, 212),
                boxShadow: [shadowList()],
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: NumberAnimation(
                decimalPoint: 2,
                before: "RM ",
                start: 0, // default is 0, can remove
                end: totalServiceSum.toInt(),
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 139, 5),
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
                duration: Duration(milliseconds: 1000),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding indicator(String image, title, pricePerService) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(121, 173, 220, 1),
              radius: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 17,
                backgroundImage: AssetImage(image),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: 10,
          ),

          Expanded(
            child: NumberAnimation(
              textAlign: TextAlign.center,
              decimalPoint: 0,
              before: "RM ",
              start: 0, // default is 0, can remove
              end: pricePerService.toInt(),
              style: TextStyle(color: Colors.green, fontSize: 14),
              duration: Duration(milliseconds: 1000),
            ),
          ),
          // Expanded(
          //   flex: 2,
          //   child: NumberSlideAnimation(
          //     number: pricePerService.round().toString(),
          //     duration: const Duration(seconds: 2),
          //     curve: Curves.easeInOut,
          //     textStyle: TextStyle(
          //         fontSize: 14.0,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.green),
          //   ),
          // ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      totalServiceSum = bhsum + dsum + lsum + gsum + ssum;
      double bhpercent = (bhsum / totalServiceSum) * 100;
      double dpercent = (dsum / totalServiceSum) * 100;
      double lpercent = (lsum / totalServiceSum) * 100;
      double gpercent = (gsum / totalServiceSum) * 100;
      double spercent = (ssum / totalServiceSum) * 100;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color.fromRGBO(128, 155, 206, 1),
            value: bhsum,
            title: bhpercent.toStringAsFixed(0) + " %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/images/basic_house_cleaning.png',
              size: widgetSize,
              borderColor: Color.fromRGBO(128, 155, 206, 1),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Color.fromRGBO(149, 184, 209, 1),
            value: dsum,
            title: dpercent.toStringAsFixed(0) + " %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            badgeWidget: _Badge(
              'assets/images/deep_cleaning.png',
              size: widgetSize,
              borderColor: const Color.fromRGBO(149, 184, 209, 1),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Color.fromRGBO(184, 224, 210, 1),
            value: lsum,
            title: lpercent.toStringAsFixed(0) + " %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/images/laundry_cleaning.png',
              size: widgetSize,
              borderColor: Color.fromRGBO(184, 224, 210, 1),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Color.fromRGBO(214, 234, 223, 1),
            value: gsum,
            title: gpercent.toStringAsFixed(0) + " %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF)),
            badgeWidget: _Badge(
              'assets/images/green_cleaning.png',
              size: widgetSize,
              borderColor: Color.fromRGBO(214, 234, 223, 1),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: Color.fromRGBO(234, 196, 213, 1),
            value: ssum,
            title: spercent.toStringAsFixed(0) + " %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/images/sanitization.png',
              size: widgetSize,
              borderColor: Color.fromRGBO(234, 196, 213, 1),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(
          svgAsset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
