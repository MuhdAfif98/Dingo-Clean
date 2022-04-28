import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/screen/user/update_profile/components/body.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/updateProfile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "Update Profile",
        color: Colors.transparent,
      ),
      body: Body(),
    );
  }
}
