import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.network(
            "https://assets5.lottiefiles.com/packages/lf20_cyf3naef.json",
            frameRate: FrameRate(75)),
            Container(
              
            )
      ],
      
    );
  }
}
