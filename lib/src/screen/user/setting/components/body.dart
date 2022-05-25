import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/user/change_language/change_language_screen.dart';
import 'package:dingo_clean/src/screen/user/change_password/change_password_screen.dart';
import 'package:dingo_clean/src/screen/user/update_profile/update_profile_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buttonSetting(const Icon(Iconsax.user), "Update Profile", () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateProfileScreen(),
            ));
      }),
      buttonSetting(const Icon(Iconsax.security), "Change Password", () {
        Navigator.restorablePushNamed(context, ChangePasswordScreen.routeName);
      }),
      buttonSetting(const Icon(Iconsax.flag), "Change Language", () {
        Navigator.restorablePushNamed(context, ChangeLanguageScreen.routeName);
      }),
      buttonSetting(const Icon(Iconsax.logout), "Logout", () {
        _signOut();
      })
    ]);
  }

  ScaleTap buttonSetting(Icon icon, String text, dynamic press) {
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
                  const SizedBox(width: 12),
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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }
}
