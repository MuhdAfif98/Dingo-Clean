import 'package:dingo_clean/src/screen/user/change_language/components/body.dart';
import 'package:dingo_clean/src/screen/user/setting/setting_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({ Key? key }) : super(key: key);
  static const routeName = '/changeLanguage';

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "Setting",
        color: Colors.transparent,
        onBackPressed: (){
          Navigator.restorablePushNamed(context, SettingScreen.routeName);
        },
      ),
      body: Body(),
    );
  }
}