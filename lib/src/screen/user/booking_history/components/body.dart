import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/model/user.dart';
import 'package:dingo_clean/src/screen/user/booking_details/booking_details_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:number_animation/number_animation.dart';

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
            .where("User ID", isEqualTo: _uid)
            .where("Payment status", isEqualTo: "Paid")
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
                    document['Service type'],
                    document['Payment status'],
                    document['Date'],
                    document['Time'],
                    document['House type'],
                    document['Total Price'],
                    document["Order created at"]
                  )
                ],
              );
            }).toList(),
          );
        });
  }

  ScaleTap buttonSetting(
      String serviceType, status, date, time, houseType, int totalPrice, Timestamp createdAt) {
    return ScaleTap(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BookingDetailsScreen(createdAt: createdAt)));
      },
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
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            if (houseType == "Apartment") ...[
                              Image.asset(
                                "assets/images/house_type/apartment.png",
                              )
                            ] else if (houseType == "Semi-D") ...[
                              Image.asset("assets/images/house_type/semi-d.png")
                            ] else if (houseType == "Bungalow") ...[
                              Image.asset(
                                  "assets/images/house_type/bungalow.png")
                            ] else if (houseType == "Condominium") ...[
                              Image.asset(
                                  "assets/images/house_type/condominium.png")
                            ] else if (houseType == "Terrace") ...[
                              Image.asset(
                                  "assets/images/house_type/terraced-house.png")
                            ],
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(serviceType),
                                subtitle: Text(status),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(date),
                              SizedBox(
                                width: 20,
                              ),
                              Text(time),
                            ],
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: NumberAnimation(
                    decimalPoint: 0,
                    before: "RM ",
                    start: 0, // default is 0, can remove
                    end: totalPrice,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    duration: Duration(milliseconds: 2000),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
