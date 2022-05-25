import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/screen/admin/financial_service/financial_screen.dart';
import 'package:dingo_clean/src/screen/admin/user_booking/booking_history_screen.dart';
import 'package:dingo_clean/src/screen/admin/homepage/components/body0.dart';
import 'package:dingo_clean/src/size_config.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomepageAdminScreen extends StatefulWidget {
  const HomepageAdminScreen({ Key? key }) : super(key: key);
static const routeName = '/homepageAdmin';
  @override
  State<HomepageAdminScreen> createState() => _HomepageAdminScreenState();
}

class _HomepageAdminScreenState extends State<HomepageAdminScreen> {
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
                activeIcon: Icon(Iconsax.dollar_circle),
                icon: Icon(Iconsax.dollar_circle),
                label: "Financial"),
            BottomNavigationBarItem(
                activeIcon: Icon(Iconsax.bookmark),
                icon: Icon(Iconsax.bookmark),
                label: "Booking"),
          ],
        ),
      ),
      body: (currentIndex == 0)
          ? const Body0()
          : (currentIndex == 1)
              ? const FinancialServiceScreen()
              : const UserBookingScreen() ,
    );
  }
}