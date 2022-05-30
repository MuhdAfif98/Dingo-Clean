import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String date;
  int housePrice;
  String houseType;
  String paymentStatus;
  int servicePrice;
  String serviceType;
  String time;
  int totalPrice;
  String userID;
  String clientName;
  String clientAddress;
  String clientContactNo;

  Booking(
      {required this.date,
      required this.housePrice,
      required this.houseType,
      required this.paymentStatus,
      required this.servicePrice,
      required this.serviceType,
      required this.time,
      required this.totalPrice,
      required this.userID,
      required this.clientName,
      required this.clientAddress,
      required this.clientContactNo});

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
        'Date': date,
        'House Price': housePrice,
        'House type': houseType,
        'Payment status': paymentStatus,
        'Service Price': servicePrice,
        'Service type': serviceType,
        'Time': time,
        'Total Price': totalPrice,
        'User ID': userID,
      };

  // creating a Trip object from a firebase snapshot
  Booking.fromSnapshot(DocumentSnapshot snapshot)
      : date = snapshot['Date'],
        housePrice = snapshot['House Price'],
        houseType = snapshot['House type'],
        paymentStatus = snapshot['Payment status'],
        servicePrice = snapshot['Service Price'],
        serviceType = snapshot['Service type'],
        time = snapshot['Time'],
        totalPrice = snapshot['Total Price'],
        userID = snapshot['User ID'],
        clientName = snapshot["Client name"],
        clientAddress = snapshot['Client Address'],
        clientContactNo = snapshot['Client Contact'];

}
