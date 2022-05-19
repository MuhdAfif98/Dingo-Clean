import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/model/user.dart';
import 'package:dingo_clean/src/screen/user/payment/payment_screen.dart';
import 'package:dingo_clean/src/screen/user/test/test.dart';
import 'package:dingo_clean/src/services/auth.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  late String _uid;
  int _currentStep = 0;
  final DatePickerController _controller = DatePickerController();
  String _selectedValue = '';
  String _selectedHour = '08:00';
  final ItemScrollController _scrollController = ItemScrollController();
  String? _selectedService;
  String? _selectedHouse;
  dynamic _servicePrice, _housePrice, _totalPrice;
  String userID = "";
  late int totalPrice;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _hours = <String>[
    '08:00 am',
    '09:00 am',
    '10:00 am',
    '11:00 am',
    '12:00 pm',
    '13:00 pm',
    '14:00 pm',
  ];

  final _services = [
    "Basic House Cleaning",
    "Deep Cleaning",
    "Laundry Cleaning",
    "Green Cleaning",
    "Sanitization",
  ];

  String? selectedValue;
  List<String> yesNo = [
    'Yes',
    'No',
  ];

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
    _addressController.text = userDoc.get('address');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      elevation: 0,
      steps: stepList(),
      onStepTapped: (int newIndex) {
        setState(() {
          _currentStep = newIndex;
        });
      },
      currentStep: _currentStep,
      onStepContinue: () {
        final isLastStep = _currentStep == stepList().length - 1;

        if (isLastStep) {
          debugPrint("Completed");
          serviceBooking();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentScreen(
                  totalPrice: _totalPrice,
                ),
              ));
        } else {
          setState(() {
            _currentStep += 1;
          });
        }
      },
      onStepCancel: () {
        if (_currentStep != 0) {
          setState(() {
            _currentStep -= 1;
          });
        }
      },
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Container(
          margin: const EdgeInsets.only(top: 15),
          child: Row(children: [
            Expanded(
                child: ElevatedButton(
                    child: const Text("Next"),
                    onPressed: details.onStepContinue)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: ElevatedButton(
              child: const Text("Cancel"),
              onPressed: details.onStepCancel,
            ))
          ]),
        );
      },
    );
  }

  List<Step> stepList() => [
        Step(
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 0,
          title: const Text(""),
          content: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Select Cleaning Service",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              const SizedBox(
                height: 10,
              ),
              FormField<String>(
                initialValue: "Please select",
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelStyle: textStyleNormal(Colors.black),
                        errorStyle: const TextStyle(
                            color: Colors.redAccent, fontSize: 16.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedService,
                        isDense: true,
                        onChanged: (newValue) {
                          _selectedService = newValue;
                          state.didChange(newValue);
                          setState(() {
                            if (_selectedService == "Basic House Cleaning") {
                              _servicePrice = int.parse('110');
                              assert(_servicePrice is int);
                              //var total = _servicePrice+1;
                              //print(total);
                            } else if (_selectedService == "Deep Cleaning") {
                              _servicePrice = int.parse('120');
                              assert(_servicePrice is int);
                            } else if (_selectedService == "Laundry Cleaning") {
                              _servicePrice = int.parse('130');
                              assert(_servicePrice is int);
                            } else if (_selectedService == "Green Cleaning") {
                              _servicePrice = int.parse('140');
                              assert(_servicePrice is int);
                            } else if (_selectedService == "Sanitization") {
                              _servicePrice = int.parse('150');
                              assert(_servicePrice is int);
                            }
                          });
                        },
                        items: _services.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Select House Type",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 120.0,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    houseType(
                        "assets/images/house_type/bungalow.png", "Bungalow"),
                    houseType("assets/images/house_type/semi-d.png", "Semi-D"),
                    houseType("assets/images/house_type/terraced-house.png",
                        "Terrace"),
                    houseType(
                        "assets/images/house_type/apartment.png", "Apartment"),
                    houseType(
                        "assets/images/house_type/condominium.png", "Condo"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Select Date and Time",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              const SizedBox(
                height: 10,
              ),
              DatePicker(
                DateTime.now(),
                width: 60,
                daysCount: 30,
                height: 80,
                controller: _controller,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.lightBlue,
                deactivatedColor: Colors.grey.shade300,
                selectedTextColor: Colors.black,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    DateTime now = DateTime.now();
                    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
                    _selectedValue = formattedDate;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ScrollablePositionedList.builder(
                    physics: const BouncingScrollPhysics(),
                    itemScrollController: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _hours.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedHour = _hours[index];
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: _selectedHour == _hours[index]
                                ? Colors.lightBlue
                                : Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _hours[index],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Step(
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 1,
            title: const Text(""),
            content: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Personal Details
                  Container(
                    padding: const EdgeInsets.all(8.0),
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                        TextFormField(
                          controller: _nameController,
                          style: textStyleNormal(primaryColor),
                          decoration: defaultInputDecoration("Name"),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _contactNoController,
                          style: textStyleNormal(primaryColor),
                          decoration: defaultInputDecoration("Contact Number"),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _addressController,
                          style: textStyleNormal(primaryColor),
                          decoration: defaultInputDecoration("Address"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  //Precaution Measure
                  // Container(
                  //   padding: const EdgeInsets.all(15.0),
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
                  //           child: const Text("Precaution Measure",
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 16))),
                  //       Padding(
                  //         padding: const EdgeInsets.all(3.0),
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //                 flex: 4, child: Text("Will you be at home?")),
                  //             Expanded(
                  //               flex: 2,
                  //               child: DropdownButtonHideUnderline(
                  //                 child: DropdownButton2(
                  //                   isExpanded: true,
                  //                   hint: Row(
                  //                     children: const [
                  //                       Expanded(
                  //                         child: Text(
                  //                           'Select',
                  //                           style: TextStyle(
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w400,
                  //                             color: Colors.black,
                  //                           ),
                  //                           overflow: TextOverflow.ellipsis,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   items: yesNo
                  //                       .map((item) => DropdownMenuItem<String>(
                  //                             value: item,
                  //                             child: Text(
                  //                               item,
                  //                               style: const TextStyle(
                  //                                 fontSize: 14,
                  //                                 color: Colors.black,
                  //                               ),
                  //                               overflow: TextOverflow.ellipsis,
                  //                             ),
                  //                           ))
                  //                       .toList(),
                  //                   value: selectedValue,
                  //                   onChanged: (value) {
                  //                     setState(() {
                  //                       selectedValue = value as String;
                  //                     });
                  //                   },
                  //                   icon: const Icon(
                  //                     Icons.arrow_forward_ios_outlined,
                  //                   ),
                  //                   iconSize: 14,
                  //                   iconEnabledColor: Colors.black,
                  //                   iconDisabledColor: Colors.grey,
                  //                   buttonHeight: 30,
                  //                   buttonWidth: 30,
                  //                   buttonPadding: const EdgeInsets.only(
                  //                       left: 14, right: 14),
                  //                   buttonDecoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     border: Border.all(
                  //                       color: Colors.black26,
                  //                     ),
                  //                     color: Colors.white,
                  //                   ),
                  //                   buttonElevation: 2,
                  //                   itemHeight: 25,
                  //                   dropdownDecoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     color: Colors.white,
                  //                   ),
                  //                   dropdownElevation: 8,
                  //                   scrollbarRadius: const Radius.circular(40),
                  //                   scrollbarThickness: 6,
                  //                   scrollbarAlwaysShow: true,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(3.0),
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //                 flex: 4, child: Text("Is parking available?")),
                  //             Expanded(
                  //               flex: 2,
                  //               child: DropdownButtonHideUnderline(
                  //                 child: DropdownButton2(
                  //                   isExpanded: true,
                  //                   hint: Row(
                  //                     children: const [
                  //                       Expanded(
                  //                         child: Text(
                  //                           'Select',
                  //                           style: TextStyle(
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w400,
                  //                             color: Colors.black,
                  //                           ),
                  //                           overflow: TextOverflow.ellipsis,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   items: yesNo
                  //                       .map((item) => DropdownMenuItem<String>(
                  //                             value: item,
                  //                             child: Text(
                  //                               item,
                  //                               style: const TextStyle(
                  //                                 fontSize: 14,
                  //                                 color: Colors.black,
                  //                               ),
                  //                               overflow: TextOverflow.ellipsis,
                  //                             ),
                  //                           ))
                  //                       .toList(),
                  //                   value: selectedValue,
                  //                   onChanged: (value) {
                  //                     setState(() {
                  //                       selectedValue = value as String;
                  //                     });
                  //                   },
                  //                   icon: const Icon(
                  //                     Icons.arrow_forward_ios_outlined,
                  //                   ),
                  //                   iconSize: 14,
                  //                   iconEnabledColor: Colors.black,
                  //                   iconDisabledColor: Colors.grey,
                  //                   buttonHeight: 30,
                  //                   buttonWidth: 30,
                  //                   buttonPadding: const EdgeInsets.only(
                  //                       left: 14, right: 14),
                  //                   buttonDecoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     border: Border.all(
                  //                       color: Colors.black26,
                  //                     ),
                  //                     color: Colors.white,
                  //                   ),
                  //                   buttonElevation: 2,
                  //                   itemHeight: 25,
                  //                   dropdownDecoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     color: Colors.white,
                  //                   ),
                  //                   dropdownElevation: 8,
                  //                   scrollbarRadius: const Radius.circular(40),
                  //                   scrollbarThickness: 6,
                  //                   scrollbarAlwaysShow: true,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       precautionQuestion("Any pets?"),
                  //       precautionQuestion("Any chemical allergic?"),
                  //       precautionQuestion("After service sanitize?"),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 15),
                ],
              ),
            )),
        Step(
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 2,
            title: const Text(""),
            content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [shadowList()]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "THANK YOU!",
                          style: textStyleBold(Colors.black, 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Your service already processed",
                            style: textStyleNormal(Colors.black, fontsize: 15)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Please wait for the worker patiently",
                            style: textStyleNormal(Colors.black, fontsize: 15)),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "DATE",
                              textAlign: TextAlign.center,
                              style: textStyleBold(Colors.black, 14),
                            )),
                            Expanded(
                                child: Text(
                              "TIME",
                              textAlign: TextAlign.center,
                              style: textStyleBold(Colors.black, 14),
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "30/12/2022",
                              textAlign: TextAlign.center,
                              style: textStyleNormal(Colors.black),
                            )),
                            Expanded(
                                child: Text(
                              "2.31 PM",
                              textAlign: TextAlign.center,
                              style: textStyleNormal(Colors.black),
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "NAME",
                              textAlign: TextAlign.center,
                              style: textStyleBold(Colors.black, 14),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Muhammad Afif bin Ab Rahman",
                              textAlign: TextAlign.center,
                              style: textStyleNormal(Colors.black),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "TOTAL",
                              textAlign: TextAlign.center,
                              style: textStyleBold(Colors.black, 14),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "RM 30.25",
                              textAlign: TextAlign.center,
                              style: textStyleNormal(Colors.black),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "PAYMENT METHOD",
                              textAlign: TextAlign.center,
                              style: textStyleBold(Colors.black, 14),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Credit Card",
                              textAlign: TextAlign.center,
                              style: textStyleNormal(Colors.black),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                )))
      ];

  ScaleTap houseType(String image, houseType) {
    return ScaleTap(
      onPressed: () {
        setState(() {
          _selectedHouse = houseType;
          if (_selectedHouse == "Bungalow") {
            _housePrice = int.parse('110');
            assert(_housePrice is int);
          } else if (_selectedHouse == "Semi-D") {
            _housePrice = int.parse('120');
            assert(_housePrice is int);
          } else if (_selectedHouse == "Terrace") {
            _housePrice = int.parse('130');
            assert(_housePrice is int);
          } else if (_selectedHouse == "Apartment") {
            _housePrice = int.parse('140');
            assert(_housePrice is int);
          } else if (_selectedHouse == "Condo") {
            _housePrice = int.parse('150');
            assert(_housePrice is int);
          }

          print(_selectedHouse);
          print(_servicePrice);
          print(_housePrice);
          _totalPrice = _housePrice + _servicePrice;
          print(_totalPrice);
        });
      },
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: houseType == _selectedHouse
                  ? Colors.blueAccent
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [shadowList()],
            ),
            width: 100,
            child: Column(
              children: [
                Image.asset(image),
                const SizedBox(
                  height: 5,
                ),
                Center(child: Text(houseType)),
              ],
            )),
      ),
    );
  }

  BoxShadow shadowList() {
    return BoxShadow(
      blurRadius: 7,
      spreadRadius: 0,
      offset: const Offset(4, 4),
      color: Colors.black.withOpacity(0.2),
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
                items: yesNo
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

//Insert data into Firebase
  void serviceBooking() {
    User? getUser = FirebaseAuth.instance.currentUser;
    userID = getUser!.uid;
    firestore.collection("booking").add({
      "User ID": userID,
      "Service type": _selectedService,
      "House type": _selectedHouse,
      "Date": _selectedValue,
      "Time": _selectedHour,
      "Service Price": _servicePrice,
      "House Price": _housePrice,
      "Total Price": _totalPrice,
      "Payment status": "Pending",
    });
  }
}
