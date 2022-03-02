import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

//Get the proportionate height as per screen size
double getProportionateScreenHeight(double size, {double inputHeight = 10}) {
  double? screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use

  return (inputHeight / 812.0) * screenHeight!;
}

//Get the proportionate width as per screen size
double getProportionateScreenWidth(double? inputWidth) {
  double? screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  if (inputWidth != null) {
    return (inputWidth / 375.0) * screenWidth!;
  } else {
    return (10 / 375.0) * screenWidth!;
  }
}

class SpacingDefault extends StatelessWidget {
  final double size;
  const SpacingDefault({
    Key? key,
    this.size = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(size),
    );
  }
}

//Get the proportionate width as per screen size
double getScreenWidth(context) {
  return MediaQuery.of(context).size.width;
}

//Get the proportionate height as per screen size
double getScreenHeight(context) {
  return MediaQuery.of(context).size.height;
}
