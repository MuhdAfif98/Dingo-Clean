import 'package:dingo_clean/src/screen/admin/financial_service/components/body.dart';
import 'package:dingo_clean/src/screen/admin/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:flutter/material.dart';

class FinancialServiceScreen extends StatefulWidget {
  const FinancialServiceScreen({Key? key}) : super(key: key);
  static const routeName = '/financialHousse';

  @override
  State<FinancialServiceScreen> createState() => _FinancialServiceScreenState();
}

class _FinancialServiceScreenState extends State<FinancialServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "Finance",
        color: Colors.transparent,
        onBackPressed: () {
          Navigator.restorablePushNamed(context, HomepageAdminScreen.routeName);
        },
      ),
      body: Body(),
    );
  }
}
