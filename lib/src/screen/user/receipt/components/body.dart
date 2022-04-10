import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [shadowList()]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "THANK YOU!",
                style: textStyleBold(Colors.black, 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Your service already processed",
                  style: textStyleNormal(Colors.black, fontsize: 15)),
              const SizedBox(
                height: 10,
              ),
              Text("Please wait for the worker patiently",
                  style: textStyleNormal(Colors.black, fontsize: 15)),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "DATE",
                    textAlign: TextAlign.center,
                    style: textStyleBold(Colors.black, 14),
                  )),
                  Expanded(
                      child: Text(
                    "TIME",
                    textAlign: TextAlign.center,
                    style: textStyleBold(Colors.black, 14),
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "30/12/2022",
                    textAlign: TextAlign.center,
                    style: textStyleNormal(Colors.black),
                  )),
                  Expanded(
                      child: Text(
                    "2.31 PM",
                    textAlign: TextAlign.center,
                    style: textStyleNormal(Colors.black),
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "NAME",
                    textAlign: TextAlign.center,
                    style: textStyleBold(Colors.black, 14),
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "Muhammad Afif bin Ab Rahman",
                    textAlign: TextAlign.center,
                    style: textStyleNormal(Colors.black),
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "TOTAL",
                    textAlign: TextAlign.center,
                    style: textStyleBold(Colors.black, 14),
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "RM 30.25",
                    textAlign: TextAlign.center,
                    style: textStyleNormal(Colors.black),
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "PAYMENT METHOD",
                    textAlign: TextAlign.center,
                    style: textStyleBold(Colors.black, 14),
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "Credit Card",
                    textAlign: TextAlign.center,
                    style: textStyleNormal(Colors.black),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxShadow shadowList() {
    return BoxShadow(
      blurRadius: 6,
      spreadRadius: 5,
      offset: const Offset(4, 4),
      color: Colors.black.withOpacity(0.2),
    );
  }
}
