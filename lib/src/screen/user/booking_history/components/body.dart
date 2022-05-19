import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _uid = '';

  String name = '';
  String image = '';
  String contactNo = '';
  String address = '';
  String city = '';
  String houseType = '';

  @override
  void initState() {
    super.initState();
    getData().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> getData() async {
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('booking').doc().get();
    name = userDoc.get('name');
    image = userDoc.get('image');
    contactNo = userDoc.get('contactNo');
    address = userDoc.get('address');
    city = userDoc.get('city');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('booking')
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
                  )
                ],
              );
            }).toList(),
          );
        });
  }

  ScaleTap buttonSetting(
      String serviceType, status, date, time, houseType, int totalPrice) {
    return ScaleTap(
      onPressed: () {},
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
                              Image.asset("assets/images/house_type/apartment.png",)
                            ] else if (houseType == "Semi-D") ...[
                              Image.asset("assets/images/house_type/semi-d.png")
                            ] else if (houseType == "Bungalow") ...[
                              Image.asset("assets/images/house_type/bungalow.png")
                            ] else if (houseType == "Condominium") ...[
                              Image.asset("assets/images/house_type/condominium.png")
                            ] else if (houseType == "Terrace") ...[
                              Image.asset("assets/images/house_type/terrace-house.png")
                            ],
                            SizedBox(width: 15,),
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
                    flex: 1,
                    child: Text(
                      "RM " + totalPrice.toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
