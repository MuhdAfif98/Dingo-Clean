import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/model/user.dart';
import 'package:dingo_clean/src/screen/user/booking_history/booking_history_screen.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/body.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/body0.dart';
import 'package:dingo_clean/src/screen/user/my_profile/my_profile_screen.dart';
import 'package:dingo_clean/src/screen/user/update_profile/update_profile_screen.dart';
import 'package:dingo_clean/src/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);
  static const routeName = '/homepageUser';
  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  int currentIndex = 0;

  var currentPageValue = 0.0;
  var mItemCount = 10;

  List<Widget> pages = [];

// bottom bar
  changePage(int index) {
    setState(() {
      FocusScope.of(context).unfocus();
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        color: Colors.pink.withOpacity(0.2),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: primaryColor,
          currentIndex: currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          onTap: changePage,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(Iconsax.home),
                icon: Icon(Iconsax.home),
                label: "Home"),
            BottomNavigationBarItem(
                activeIcon: Icon(Iconsax.clock),
                icon: Icon(Iconsax.clock),
                label: "History"),
            BottomNavigationBarItem(
                activeIcon: Icon(Iconsax.user),
                icon: Icon(Iconsax.user),
                label: "Profile"),
          ],
        ),
      ),
      body: (currentIndex == 0)
          ? const Body0()
          : (currentIndex == 1)
              ? const BookingHistoryScreen()
              : const MyProfileScreen(),
    );
  }
}
