import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/user/booking_1/booking_1_screen.dart';
import 'package:dingo_clean/src/screen/user/setting/setting_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScaleTap(
                    onPressed: () {
                      Navigator.restorablePopAndPushNamed(
                          context, SettingScreen.routeName);
                    },
                    child: Material(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        "https://imgix.ranker.com/user_node_img/50126/1002515936/original/1002515936-photo-u2?auto=format&q=60&fit=crop&fm=pjpg&dpr=2&w=375",
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: textStyleNormal(Colors.white),
                        ),
                        Text(
                          "USER",
                          style: textStyleBold(Colors.white, 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  ScaleTap(
                    onPressed: () {
                      Navigator.restorablePushNamed(
                          context, SignInScreen.routeName);
                    },
                    child: const Icon(
                      Iconsax.logout,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),

            //carousel
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 150.0,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  adsCard(),
                  adsCard(),
                  adsCard(),
                  adsCard(),
                ],
              ),
            ),

            Text(
              "Cleaning Services",
              style: textStyleBold(Colors.black, 20),
            ),
            const SizedBox(height: 15),

            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  servicesList(),
                  const SizedBox(
                    height: 10,
                  ),
                  servicesList(),
                  const SizedBox(
                    height: 10,
                  ),
                  servicesList()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Card adsCard() {
    return Card(
      color: Colors.red,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const SizedBox(
          width: 200,
          child: Center(
            child: Text("Advertisement"),
          )),
    );
  }

  Row servicesList() {
    return Row(
      children: [
        Expanded(
          child: ScaleTap(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/clean1_1.png"),
              decoration: BoxDecoration(
                gradient: revertPrimaryGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [shadowList()],
              ),
            ),
            onPressed: () {
              Navigator.restorablePushNamed(
                  context, Booking1Screen.routeName);
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: ScaleTap(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/clean1_1.png"),
              decoration: BoxDecoration(
                gradient: revertPrimaryGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [shadowList()],
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
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
}
