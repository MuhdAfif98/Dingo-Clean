import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var newPassword = "";
  var oldPassword = "";
  String? _uid;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('user').doc(_uid).get();
    oldPassword = userDoc.get('password');
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomepageScreen(),
          ));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Your password has been changed, Please login again")));
    } catch (error) {
      print("Change password process failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              inputText("Old Password", oldPasswordController,
                  (val) => val!.isEmpty ? "Enter old password" : null),
              inputText(
                "New Password",
                newPasswordController,
                (String? value) {
                  newPassword = value!;
                  if (value.isEmpty) {
                    return "Please enter new password";
                  } else if (value.length < 3) {
                    return "Password must be at least 3 characters";
                  }
                  return null;
                },
              ),
              inputText(
                "Confirm Password",
                confirmPasswordController,
                (String? value) {
                  if (value!.isEmpty) {
                    return "Please re-enter the password";
                  } else if (value != newPassword) {
                    return "Password is not match";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: DefaultButton(
              title: "Change Password",
              color: secondaryColor,
              press: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    newPassword = newPasswordController.text;
                  });
                  changePassword();
                }
              }),
        ));
  }
}

Widget inputText(String hintText, TextEditingController input,
    String? Function(String?)? validate) {
  return Column(children: [
    //Input text
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validate,
        controller: input,
        //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        obscureText: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textStyleNormal(textGray),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: textGray),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: primaryColor, width: 1),
          ),
        ),
      ),
    )
  ]);
}
