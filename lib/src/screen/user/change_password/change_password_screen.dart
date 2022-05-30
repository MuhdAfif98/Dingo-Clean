import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/admin/setting/setting_screen.dart';
import 'package:dingo_clean/src/screen/user/change_password/components/body.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/changePassword';
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        "Change Password",
        primaryBg: false,
        onBackPressed: (){
          Navigator.restorablePushNamed(context, SettingScreen.routeName);
        },
      ),
      backgroundColor: Colors.white,
      
      body: const Body(),
    );
  }
}
