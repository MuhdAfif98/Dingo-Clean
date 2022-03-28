import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/user/change_language/change_language_screen.dart';
import 'package:dingo_clean/src/screen/user/change_password/change_password_screen.dart';
import 'package:dingo_clean/src/screen/user/setting/setting_screen.dart';
import 'package:dingo_clean/src/screen/user/update_profile/update_profile_screen.dart';
import 'package:dingo_clean/src/theme.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.topLeft,
          child: Image.asset("assets/images/language.png", scale: 3)),
      const ListTile(
        title: Text(
          "Choose Your Preferred Language",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Please select your language"),
      ),
      const SizedBox(
        height: 10,
      ),
      buttonSetting(
          Image.asset(
            'icons/flags/png/my.png',
            package: 'country_icons',
            width: 75,
          ),
          "Bahasa Malaysia", () {
        Navigator.restorablePushNamed(context, SettingScreen.routeName);
      }),
      buttonSetting(
          Image.asset(
            'icons/flags/png/gb.png',
            package: 'country_icons',
            width: 75,
          ),
          "English", () {
        Navigator.restorablePushNamed(context, SettingScreen.routeName);
      }),
      buttonSetting(
          Image.asset(
            'icons/flags/png/fr.png',
            package: 'country_icons',
            width: 75,
          ),
          "French", () {
        Navigator.restorablePushNamed(context, SettingScreen.routeName);
      }),
    ]);
  }

  ScaleTap buttonSetting(Image icon, String text, dynamic press) {
    return ScaleTap(
      onPressed: press,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                shadowList(),
              ]),
          child: Material(
            color: Colors.white.withOpacity(0.0),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
              child: Row(
                children: [
                  icon,
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(text, style: textStyleBold(Colors.black, 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
