import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/authentication/sign_up2/sign_up2_screen.dart';
import 'package:dingo_clean/src/services/database.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dingo_clean/src/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String text = "";
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();

  var password;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        style: textStyleNormal(primaryColor),
                        decoration: defaultInputDecoration(
                            "Name", const Icon(Iconsax.user)),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        style: textStyleNormal(primaryColor),
                        decoration: defaultInputDecoration(
                            "Email", const Icon(Iconsax.gallery)),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        style: textStyleNormal(primaryColor),
                        decoration: passwordInputDecoration("Password"),
                        obscureText: true,
                        obscuringCharacter: "*",
                        validator: (String? value) {
                          password = value;
                          if (value!.isEmpty) {
                            return "Please enter password";
                          } else if (value.length < 3) {
                            return "Password must be at least 3 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: textStyleNormal(primaryColor),
                        decoration: passwordInputDecoration("Confirm Password"),
                        obscureText: true,
                        obscuringCharacter: "*",
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please re-enter the password";
                          } else if (value != password) {
                            return "Password is not match";
                          }
                          return null;
                        },
                      ),
                      Visibility(
                        visible: false,
                        child: TextFormField(
                          controller: _contactNoController,
                          keyboardType: TextInputType.phone,
                          style: textStyleNormal(secondaryColor),
                          decoration: defaultInputDecoration(
                              "Contact Number", const Icon(Iconsax.call)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: false,
                        child: TextFormField(
                          controller: _addressController,
                          style: textStyleNormal(secondaryColor),
                          decoration: defaultInputDecoration(
                              "Address", const Icon(Iconsax.location)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: false,
                        child: TextFormField(
                          controller: _cityController,
                          style: textStyleNormal(secondaryColor),
                          decoration: defaultInputDecoration(
                              "City", const Icon(Iconsax.map)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: false,
                        child: TextFormField(
                          controller: _stateController,
                          style: textStyleNormal(secondaryColor),
                          decoration: defaultInputDecoration(
                              "State", const Icon(Iconsax.gps)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: false,
                        child: TextFormField(
                          controller: _postcodeController,
                          keyboardType: TextInputType.number,
                          style: textStyleNormal(secondaryColor),
                          decoration: defaultInputDecoration(
                              "Postcode", const Icon(Iconsax.map_1)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: DefaultButton(
                  title: "Next",
                  press: () async {
                    signUp();
                  },
                )),
          );
        });
  }

  InputDecoration defaultInputDecoration(String? hintText, Widget? icon) {
    return InputDecoration(
      prefix: icon,
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
      hintText: hintText,
    );
  }

  InputDecoration passwordInputDecoration(String? hintText) {
    return InputDecoration(
        suffixIcon: const Icon(
          Iconsax.eye4,
          color: primaryColor,
        ),
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

  void signUp() async {
    dynamic result = await _auth.registerAccount(
      _nameController.text,
      _imageController.text,
      _contactNoController.text,
      _addressController.text,
      _stateController.text,
      _cityController.text,
      _postcodeController.text,
      _emailController.text,
      _passwordController.text,
    );
    if (result == null) {
      debugPrint('Email is not valid');
    } else {
      debugPrint(result.toString());
      _nameController.clear();
      _passwordController.clear();
      _emailController.clear();
      _imageController.clear();
      _contactNoController.clear();
      _addressController.clear();
      _stateController.clear();
      _cityController.clear();
      _postcodeController.clear();

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignUp2Screen()));
    }
  }
}
