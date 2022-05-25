import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/model/booking.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:intl/intl.dart';

Widget buildBookingCard(BuildContext context, DocumentSnapshot document) {
  final booking = Booking.fromSnapshot(document);
  final tripType = booking.types();

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
                          if (booking.houseType == "Apartment") ...[
                            Image.asset(
                              "assets/images/house_type/apartment.png",
                            )
                          ] else if (booking.houseType == "Semi-D") ...[
                            Image.asset("assets/images/house_type/semi-d.png")
                          ] else if (booking.houseType == "Bungalow") ...[
                            Image.asset("assets/images/house_type/bungalow.png")
                          ] else if (booking.houseType == "Condominium") ...[
                            Image.asset(
                                "assets/images/house_type/condominium.png")
                          ] else if (booking.houseType == "Terrace") ...[
                            Image.asset(
                                "assets/images/house_type/terraced-house.png")
                          ],
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(booking.serviceType),
                              subtitle: Text(booking.paymentStatus),
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
                            Text(booking.date),
                            SizedBox(
                              width: 20,
                            ),
                            Text(booking.time),
                          ],
                        )),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    "RM " + booking.totalPrice.toString(),
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
