import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buttonSetting(() {}),
      buttonSetting(() {}),
      buttonSetting(() {}),
      buttonSetting(() {})
    ]);
  }

  ScaleTap buttonSetting(dynamic press) {
    return ScaleTap(
      onPressed: press,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
          width: double.infinity,
          height: 100,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                shadowList(),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/flutter_logo.png"),
                          const Expanded(
                            child: ListTile(
                              title: Text("Green Cleaning"),
                              subtitle: Text("Kampung Guntung Luar"),
                            ),
                          )
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: const [
                              Text("8/1/2021"),
                              SizedBox(
                                width: 15,
                              ),
                              Text("14:01"),
                            ],
                          )),
                    ],
                  ),
                ),
                const Expanded(
                    flex: 1,
                    child: Text(
                      "RM 90.90",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
