import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  String _selectedHour = '08:00';
  final ItemScrollController _scrollController = ItemScrollController();

  final List<String> _hours = <String>[
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
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
                houseType("assets/images/house_type/bungalow.png", "Bungalow"),
                houseType("assets/images/house_type/semi-d.png", "Semi-D"),
                houseType(
                    "assets/images/house_type/terraced-house.png", "Terrace"),
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
                        border: Border.all(
                          color: _selectedHour == _hours[index]
                              ? Colors.blue.shade900
                              : Colors.white.withOpacity(0),
                          width: 1.5,
                        ),
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
          const SizedBox(
            height: 10,
          ),
          // Container(
          //     alignment: Alignment.centerLeft,
          //     child: const Text(
          //       "Additional Service",
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //     )),
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 20.0),
          //   height: 100.0,
          //   child: ListView(
          //     physics: const BouncingScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     children: [
          //       addServices(),
          //       addServices(),
          //       addServices(),
          //       addServices(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  ScaleTap houseType(String image, houseType) {
    return ScaleTap(
      onPressed: (){},
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
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

  // Card addServices() {
  //   return Card(
  //     color: Colors.red,
  //     elevation: 2,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     child: const SizedBox(
  //         width: 100,
  //         child: Center(
  //           child: Text("Additional Services"),
  //         )),
  //   );
  // }

  BoxShadow shadowList() {
    return BoxShadow(
      blurRadius: 7,
      spreadRadius: 0,
      offset: const Offset(4, 4),
      color: Colors.black.withOpacity(0.2),
    );
  }
}
