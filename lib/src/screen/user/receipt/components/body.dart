import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/model/user.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String userID = '';
  User? auth = FirebaseAuth.instance.currentUser;
  late final String _uid = auth!.uid;

  String name = '';
  String image = '';
  String contactNo = '';
  String address = '';
  String city = '';
  String houseType = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('booking')
            .doc(_uid)
            .collection("service")
            .orderBy("Order created at", descending: true)
            .limit(1)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Column(
                children: [
                  buttonSetting(
                    document['Client name'],
                    document['Client Address'],
                    document['Date'],
                    document['Time'],
                    document['Total Price'],
                  )
                ],
              );
            }).toList(),
          );
        });
  }

  Padding buttonSetting(
      String clientName, clientAddress, date, time, int totalPrice) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              shadowList(),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
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
                    date,
                    textAlign: TextAlign.center,
                    style: textStyleNormal(Colors.black),
                  )),
                  Expanded(
                      child: Text(
                    time,
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
                    clientName,
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
                    "ADDRESS",
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
                    clientAddress,
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
                    "TOTAL PRICE",
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
                    "RM $totalPrice",
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
}
