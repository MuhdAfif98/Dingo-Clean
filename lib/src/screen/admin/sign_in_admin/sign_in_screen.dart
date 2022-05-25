import 'package:dingo_clean/src/screen/admin/sign_in_admin/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInAdminScreen extends StatefulWidget {
  const SignInAdminScreen({ Key? key }) : super(key: key);

  static const routeName = "/signInAdmin";

  @override
  _SignInAdminScreenState createState() => _SignInAdminScreenState();
}

class _SignInAdminScreenState extends State<SignInAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}