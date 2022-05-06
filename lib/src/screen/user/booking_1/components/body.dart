import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/screen/user/payment/payment_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _currentStep = 0;
  final DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  String _selectedHour = '08:00';
  final ItemScrollController _scrollController = ItemScrollController();
  String? _selectedService;
  String? _selectedHouse;
  late int servicePrice, housePrice, totalPrice;

  final List<String> _hours = <String>[
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
  ];

  final _services = [
    "Basic House Cleaning",
    "Deep Cleaning",
    "Laundry Cleaning",
    "Green Cleaning",
    "Sanitization",
  ];

  String? selectedValue;
  List<String> items = [
    'Yes',
    'No',
  ];

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
          Navigator.restorablePushNamed(context, PaymentScreen.routeName);
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
          title: const Text("Cleaning Service"),
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
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelStyle: textStyleNormal(Colors.black),
                        errorStyle: const TextStyle(
                            color: Colors.redAccent, fontSize: 16.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    isEmpty: _selectedService == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedService,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            if (_selectedService == "Basic House Cleaning") {
                              servicePrice = 100;
                            } else if (_selectedService == "Deep Cleaning") {
                              servicePrice = 110;
                            } else if (_selectedService == "Laundry Cleaning") {
                              servicePrice = 120;
                            } else if (_selectedService == "Green Cleaning") {
                              servicePrice = 130;
                            } else if (_selectedService == "Sanitization") {
                              servicePrice = 150;
                            }
                            _selectedService = newValue;
                            state.didChange(newValue);
                            print(servicePrice);
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
                    _selectedValue = date;
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
              Text(_selectedHour.toString()),
              Text(_selectedValue.toString()),
              Text(_selectedService.toString()),
              Text(_selectedHouse.toString()),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Step(
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 1,
            title: const Text("Detailed Information"),
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                        precautionQuestion("Will you be at home?"),
                        precautionQuestion("Is parking available?"),
                        precautionQuestion("Any pets?"),
                        precautionQuestion("Any chemical allergic?"),
                        precautionQuestion("After service sanitize?"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ))
      ];

  ScaleTap houseType(String image, houseType) {
    return ScaleTap(
      onPressed: () {
        setState(() {
          if (_selectedHouse == "Bungalow") {
            housePrice = 100;
          } else if (_selectedHouse == "Semi-D") {
            housePrice = 110;
          } else if (_selectedHouse == "Terrace") {
            housePrice = 120;
          } else if (_selectedHouse == "Apartment") {
            housePrice = 130;
          } else if (_selectedHouse == "Condo") {
            housePrice = 150;
          }
          _selectedHouse = houseType;
          print(_selectedHouse);
          print(housePrice);
          calculateTotalPrice();
          print(totalPrice);
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

  void calculateTotalPrice() {
    totalPrice = housePrice + servicePrice;
  }
}
