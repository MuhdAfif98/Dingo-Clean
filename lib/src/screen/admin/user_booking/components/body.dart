import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/model/booking.dart';
import 'package:dingo_clean/src/model/user.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:dingo_clean/src/widget/booking_card.dart';
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
  TextEditingController _searchController = TextEditingController();
  String userID = '';
  User? auth = FirebaseAuth.instance.currentUser;
  late final String _uid = auth!.uid;

  String name = '';
  String image = '';
  String contactNo = '';
  String address = '';
  String city = '';
  String houseType = '';

  late Future resultsLoaded;
  List _allResult = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getData();
  }

  _onSearchChanged() {
    searchResultLists();
    print(_searchController.text);
  }

  searchResultLists() {
    var showResults = [];

    if (_searchController.text != "") {
      //Have search parameter
      for (var bookingSnapshot in _allResult) {
        var serviceType =
            Booking.fromSnapshot(bookingSnapshot).serviceType.toLowerCase();

        if (serviceType.contains(_searchController.text.toLowerCase())) {
          showResults.add(bookingSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResult);
    }

    setState(() {
      _resultsList = showResults;
    });
  }

  getData() async {
    var data =
        await FirebaseFirestore.instance.collection("bookingAdmin").get();
    setState(() {
      _allResult = data.docs;
    });
    searchResultLists();
    return "Completed";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: kElevationToShadow[8],
              ),
              child: TextField(
                  controller: _searchController,
                  decoration:
                      InputDecoration(prefixIcon: Icon(Iconsax.search_normal),border: InputBorder.none)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height),
            width: (MediaQuery.of(context).size.width),
            child: ListView.builder(
              itemCount: _resultsList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildBookingCard(context, _resultsList[index]),
            ),
          ),
        ],
      ),
    );
  }
}
