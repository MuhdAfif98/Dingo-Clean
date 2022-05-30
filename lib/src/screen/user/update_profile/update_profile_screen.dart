import 'dart:io';
import 'package:dingo_clean/src/screen/user/my_profile/my_profile_screen.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/model/user.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/screen/user/update_profile/components/body.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/updateProfile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  late String _uid;
  bool isLoading = false;
  MyUser? user;
  File? file;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('user').doc(_uid).get();
    _nameController.text = userDoc.get('name');
    _contactNoController.text = userDoc.get('contactNo');
    _imageController.text = userDoc.get('image');
    _addressController.text = userDoc.get('address');
    _cityController.text = userDoc.get('city');
    _stateController.text = userDoc.get('state');
    _postcodeController.text = userDoc.get('postcode');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: ThemeAppBar(
        "Update Profile",
        color: Colors.transparent,
        onBackPressed: (){
          Navigator.restorablePushNamed(context, MyProfileScreen.routeName);
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imagePlaceHolder(),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                style: textStyleNormal(secondaryColor),
                decoration: defaultInputDecoration("Name"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contactNoController,
                style: textStyleNormal(secondaryColor),
                decoration: defaultInputDecoration("Contact No"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                style: textStyleNormal(secondaryColor),
                decoration: defaultInputDecoration("Address"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _cityController,
                style: textStyleNormal(secondaryColor),
                decoration: defaultInputDecoration("City"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _stateController,
                style: textStyleNormal(secondaryColor),
                decoration: defaultInputDecoration("State"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _postcodeController,
                style: textStyleNormal(secondaryColor),
                decoration: defaultInputDecoration("Postcode"),
              ),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  updateProfile0(context);
                  updateProfile();
                },
                label: Row(
                  children: const [
                    Icon(
                      Iconsax.edit,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Update")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration defaultInputDecoration(String? hintText) {
    return InputDecoration(
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

  Widget imagePlaceHolder() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTap(
            onPressed: () {
              chooseImage();
            },
            child: FDottedLine(
              color: textGray,
              corner: FDottedLineCorner.all(70),
              space: 10,
              strokeWidth: 2,
              dottedLength: 10,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: file == null
                          ? NetworkImage(_imageController.text)
                          : FileImage(file!) as ImageProvider,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  updateProfile() {
    var user = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("user").doc(user!.uid).update({
      "name": _nameController.text,
      "contactNo": _contactNoController.text,
      "city": _cityController.text,
      "address": _addressController.text,
      "image": _imageController.text,
      "postcode": _postcodeController.text,
      "state": _stateController.text
    }).then((_) {
      print("Successfully update user profile");
    });
    setState(() {
      Navigator.of(this.context).push(
        MaterialPageRoute(
          builder: (context) => MyProfileScreen(),
        ),
      );
    });
  }

  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    debugPrint('File ' + xfile!.path);
    file = File(xfile.path);
    setState(() {
      uploadImage();
    });
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(
            FirebaseAuth.instance.currentUser!.uid + "_" + basename(file!.path))
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }

  updateProfile0(BuildContext context) async {
    Map<String, dynamic> map = Map();

    /// Image
    if (file != null) {
      String url = await uploadImage();
      map['image'] = url;
    }
    map['address'] = _addressController.text;
    map['contactNo'] = _contactNoController.text;
    map['city'] = _cityController.text;
    map['state'] = _stateController.text;
    map['postcode'] = _postcodeController.text;

    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
  }
}
