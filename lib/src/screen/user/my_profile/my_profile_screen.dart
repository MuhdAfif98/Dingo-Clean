import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/model/user.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/screen/user/my_profile/components/body.dart';

import 'package:dingo_clean/src/screen/user/update_profile/update_profile_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key})
      : super(key: key);
  static const routeName = '/myProfile';

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  MyUser? currentUser;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "My Profile",
        color: Colors.transparent,
        onBackPressed: (){
          Navigator.restorablePushNamed(context, HomepageScreen.routeName);
        },
        primaryBg: false,
      ),
      body: Body(),
    );
  }
}
