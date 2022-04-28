import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/authentication/verification_code/verification_code_screen.dart';
import 'package:dingo_clean/src/services/database.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  List userList = [];

  String userID = "";
  String name = '';
  String image = '';

  File? file;

  var password;

  @override
  void initState() {
    super.initState();
    fetchUserInfo().whenComplete(() {
      setState(() {});
    });
    fetchDatabaseList();
  }

  fetchUserInfo() async {
    User? getUser = FirebaseAuth.instance.currentUser;
    userID = getUser!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('user').doc(userID).get();
    name = userDoc.get('name');
    image = userDoc.get('image');
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseService().getUserdata();

    if (resultant == null) {
      debugPrint('Unable to retrieve');
    } else {
      setState(() {
        userList = resultant;
      });
    }
  }

  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    debugPrint('File ' + xfile!.path);
    file = File(xfile.path);
    setState(() {
      uploadImage();
    });
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(
            FirebaseAuth.instance.currentUser!.uid + "_" + basename(file!.path))
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }

  updateProfile(BuildContext context) async {
    Map<String, dynamic> map = Map();

    /// Image
    if (file != null) {
      String url = await uploadImage();
      map['image'] = url;
    }
    map['address'] = _addressController.text;
    map['contactNo'] = _contactNoController.text;
    map['city'] = _cityController.text;
    map['state'] = _stateController.text;
    map['postcode'] = _postcodeController.text;

    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imagePlaceHolder(),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contactNoController,
                keyboardType: TextInputType.phone,
                style: textStyleNormal(secondaryColor),
                decoration: defaultInputDecoration(
                    "Contact Number", const Icon(Iconsax.call)),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                style: textStyleNormal(secondaryColor),
                decoration: defaultInputDecoration(
                    "Address", const Icon(Iconsax.location)),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _cityController,
                style: textStyleNormal(secondaryColor),
                decoration:
                    defaultInputDecoration("City", const Icon(Iconsax.map)),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _stateController,
                style: textStyleNormal(secondaryColor),
                decoration:
                    defaultInputDecoration("State", const Icon(Iconsax.gps)),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _postcodeController,
                keyboardType: TextInputType.number,
                style: textStyleNormal(secondaryColor),
                decoration: defaultInputDecoration(
                    "Postcode", const Icon(Iconsax.map_1)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: DefaultButton(
            title: "Register",
            press: () {
              updateProfile(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            },
          )),
    );
  }

  InputDecoration defaultInputDecoration(String? hintText, Widget? prefix) {
    return InputDecoration(
        prefixIcon: prefix,
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
          ScaleTap(
            onPressed: () {
              chooseImage();
            },
            child: FDottedLine(
              width: double.infinity,
              color: textGray,
              corner: FDottedLineCorner.all(15),
              space: 13,
              strokeWidth: 2,
              dottedLength: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 40,
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: file == null
                          ? const NetworkImage(
                              'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFile%3ASample_User_Icon.png&psig=AOvVaw0zn7ghlbG6NVHaZW3ZY9Ub&ust=1650167726808000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCICQt_vXl_cCFQAAAAAdAAAAABAI')
                          : FileImage(file!) as ImageProvider,
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
          ),
        ],
      ),
    );
  }

  submitAction(BuildContext context) {
    updateData(
        _imageController.text,
        _addressController.text,
        _cityController.text,
        _contactNoController.text,
        _postcodeController.text,
        _stateController.text,
        userID);
    _imageController.clear();
  }

  void updateData(
    String image,
    String address,
    String city,
    String contactNo,
    String postcode,
    String state,
    String userID,
  ) async {
    await DatabaseService().updateUserData(
      image,
      address,
      city,
      contactNo,
      postcode,
      state,
      userID,
    );
    fetchDatabaseList();
  }
}
