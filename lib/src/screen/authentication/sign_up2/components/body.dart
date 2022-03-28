import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              style: textStyleNormal(secondaryColor),
              decoration:
                  defaultInputDecoration("Email", const Icon(Iconsax.message)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.phone,
              style: textStyleNormal(secondaryColor),
              decoration: defaultInputDecoration(
                  "Contact Number", const Icon(Iconsax.call)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(secondaryColor),
              decoration:
                  defaultInputDecoration("Address", const Icon(Iconsax.location)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(secondaryColor),
              decoration:
                  defaultInputDecoration("City", const Icon(Iconsax.map)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: textStyleNormal(secondaryColor),
              decoration:
                  defaultInputDecoration("State", const Icon(Iconsax.gps)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              style: textStyleNormal(secondaryColor),
              decoration: defaultInputDecoration(
                  "Postcode", const Icon(Iconsax.map_1)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
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
}
