import 'dart:math';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 300,
          child: PieChart(
            PieChartData(
                centerSpaceRadius: 10,
                borderData: FlBorderData(show: false),
                sections: [
                  PieChartSectionData(
                      value: 10, color: Colors.purple, radius: 100),
                  PieChartSectionData(
                      value: 20, color: Colors.amber, radius: 110),
                  PieChartSectionData(
                      value: 30, color: Colors.green, radius: 120)
                ]),
            swapAnimationDuration: const Duration(milliseconds: 1000),
            swapAnimationCurve: Curves.bounceIn,
          ),
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
}
