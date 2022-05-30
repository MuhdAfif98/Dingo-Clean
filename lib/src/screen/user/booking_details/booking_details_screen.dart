import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/booking_history/booking_history_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BookingDetailsScreen extends StatefulWidget {
  final Timestamp createdAt;
  const BookingDetailsScreen({
    Key? key,
    required this.createdAt,
  }) : super(key: key);
  static const routeName = '/bookingDetails';
  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  String userID = '';
  User? auth = FirebaseAuth.instance.currentUser;
  late final String _uid = auth!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "Booking Details",
        color: Colors.transparent,
        onBackPressed: (){
          Navigator.restorablePushNamed(context, BookingHistoryScreen.routeName);
        },
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('booking')
              .doc(_uid)
              .collection("service")
              .where("Order created at", isEqualTo: widget.createdAt)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      document['House type'],
                      document['Service type'],
                      document['Client Contact'],
                      document['Total Price'],
                    )
                  ],
                );
              }).toList(),
            );
          }),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: DefaultButton(
            title: "Back",
            press: () {
              Navigator.restorablePushNamed(
                  context, BookingHistoryScreen.routeName);
            },
          )),
    );
  }

  Padding buttonSetting(String clientName, clientAddress, date, time, houseType,
      serviceType, clientContactNo, int totalPrice) {
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
              if (houseType == "Apartment") ...[
                Image.asset(
                  "assets/images/house_type/apartment.png",
                )
              ] else if (houseType == "Semi-D") ...[
                Image.asset("assets/images/house_type/semi-d.png")
              ] else if (houseType == "Bungalow") ...[
                Image.asset("assets/images/house_type/bungalow.png")
              ] else if (houseType == "Condominium") ...[
                Image.asset("assets/images/house_type/condominium.png")
              ] else if (houseType == "Terrace") ...[
                Image.asset("assets/images/house_type/terraced-house.png")
              ],
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "HOUSE TYPE",
                    textAlign: TextAlign.center,
                    style: textStyleBold(Colors.black, 14),
                  )),
                  Expanded(
                      child: Text(
                    "SERVICE TYPE",
                    textAlign: TextAlign.center,
                    style: textStyleBold(Colors.black, 14),
                  ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    houseType,
                    textAlign: TextAlign.center,
                    style: textStyleNormal(Colors.black),
                  )),
                  Expanded(
                      child: Text(
                    serviceType,
                    textAlign: TextAlign.center,
                    style: textStyleNormal(Colors.black),
                  ))
                ],
              ),
              SizedBox(
                height: 10,
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
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "CLIENT NAME",
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
                    "CLIENT ADDRESS",
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
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "CLIENT ADDRESS",
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
                    clientContactNo,
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
