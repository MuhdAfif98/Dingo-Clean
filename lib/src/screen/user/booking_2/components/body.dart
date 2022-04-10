import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? selectedValue;
  List<String> items = [
    'Yes',
    'No',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Personal Details
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [shadowList()],
              ),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 5, bottom: 10),
                      child: const Text("Personal Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                  TextFormField(
                    style: textStyleNormal(primaryColor),
                    decoration: defaultInputDecoration("Name"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: textStyleNormal(primaryColor),
                    decoration: defaultInputDecoration("Contact Number"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: textStyleNormal(primaryColor),
                    decoration: defaultInputDecoration("Address"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            //Precaution Measure
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [shadowList()],
              ),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 5, bottom: 10),
                      child: const Text("Precaution Measure",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                  precautionQuestion("Will you be at home?"),
                  precautionQuestion("Is parking available?"),
                  precautionQuestion("Any pets?"),
                  precautionQuestion("Any chemical allergic?"),
                  precautionQuestion("After service sanitize?"),
                ],
              ),
            ),
            const SizedBox(height: 15),
            //Cleaning Area
            // Container(
            //   padding: const EdgeInsets.all(8.0),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //     boxShadow: [shadowList()],
            //   ),
            //   child: Column(
            //     children: [
            //       Container(
            //           alignment: Alignment.centerLeft,
            //           padding: const EdgeInsets.only(left: 5, bottom: 10),
            //           child: const Text("Cleaning Area",
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold, fontSize: 16))),
  
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Padding precautionQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text(question)),
          Expanded(
            flex: 2,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                iconSize: 14,
                iconEnabledColor: Colors.black,
                iconDisabledColor: Colors.grey,
                buttonHeight: 30,
                buttonWidth: 30,
                buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.white,
                ),
                buttonElevation: 2,
                itemHeight: 25,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration defaultInputDecoration(String? hintText) {
    return InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.transparent),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor),
            gapPadding: 10),
        contentPadding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.transparent),
          gapPadding: 10,
        ),
        fillColor: disabledBg,
        filled: true,
        hintStyle: textStyleMedium(),
        hintText: hintText);
  }

  BoxShadow shadowList() {
    return BoxShadow(
      blurRadius: 6,
      spreadRadius: 5,
      offset: const Offset(4, 4),
      color: Colors.black.withOpacity(0.2),
    );
  }
}
