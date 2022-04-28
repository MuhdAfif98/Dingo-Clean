import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatefulWidget {
  
  const Body({Key? key,}) : super(key: key);
 

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _uid;

  var _nameController = TextEditingController();

  String name = '';
  String image = '';
  String contactNo = '';
  String address = '';
  String city = '';
  String state = '';
  String postcode = '';
  bool _isEnabled = true;

  @override
  void initState() {
    _nameController.text = name;
    super.initState();
    getData().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('user').doc(_uid).get();
    name = userDoc.get('name');
    image = userDoc.get('image');
    contactNo = userDoc.get('contactNo');
    address = userDoc.get('address');
    city = userDoc.get('city');
    state = userDoc.get('state');
    postcode = userDoc.get('postcode');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FDottedLine(
              color: textGray,
              corner: FDottedLineCorner.all(70),
              space: 10,
              strokeWidth: 2,
              dottedLength: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(image),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration("Name"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: _isEnabled,
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration(contactNo),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration(address),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration(city),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration(state),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(primaryColor),
              decoration: defaultInputDecoration(postcode),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
              onPressed: () {},
              label: Row(
                children: const [
                  Icon(
                    Iconsax.edit,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Update")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration defaultInputDecoration(String? hintText) {
    return InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.transparent),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: primaryColor),
            gapPadding: 10),
        contentPadding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.transparent),
          gapPadding: 10,
        ),
        fillColor: lightPrimaryColor,
        filled: true,
        hintStyle: textStyleMedium(),
        hintText: hintText);
  }

  Widget imagePlaceHolder() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FDottedLine(
            width: double.infinity,
            color: textGray,
            corner: FDottedLineCorner.all(15),
            space: 13,
            strokeWidth: 2,
            dottedLength: 10,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 40,
                  ),
                  child: Icon(
                    Iconsax.user,
                    color: textGray,
                    size: 54,
                  ),
                ),
                Text(
                  "Upload Your Selfie",
                  style: textStyleMedium(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
