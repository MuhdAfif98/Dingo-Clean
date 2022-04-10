import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/user/booking_1/booking_1_screen.dart';
import 'package:dingo_clean/src/screen/user/setting/setting_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
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
                          "ADMIN",
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
                  adsCard("assets/images/samsung.jpg", "Samsung",
                      "https://www.samsung.com/my/"),
                  adsCard("assets/images/clorox.jpg", "Clorox",
                      "https://www.clorox.com/"),
                  adsCard(
                      "assets/images/lg.jpg", "LG", "https://www.lg.com/my"),
                  adsCard("assets/images/karcher.jpg", "Karcher",
                      "https://www.kaercher.com/int/"),
                  adsCard("assets/images/dettol.jpg", "Dettol",
                      "https://www.dettol.com.my/en/"),
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
                  servicesList(
                      "assets/images/basic_house_cleaning.png",
                      "assets/images/deep_cleaning.png",
                      "Basic House Cleaning",
                      "Deep Cleaning"),
                  const SizedBox(
                    height: 10,
                  ),
                  servicesList(
                      "assets/images/laundry_cleaning.png",
                      "assets/images/sanitization.png",
                      "Laundry Cleaning",
                      "Sanitization"),
                  const SizedBox(
                    height: 10,
                  ),
                  servicesList(
                      "assets/images/green_cleaning.png",
                      "assets/images/under_maintenance.png",
                      "Green Cleaning",
                      "Under Maintenance ")
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  ScaleTap adsCard(String image, String title, String link) {
    return ScaleTap(
      onPressed: () => _launchURL(link),
      child: Card(
          color: Colors.white,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    opacity: 1,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.white.withOpacity(0.7)),
                      // color: Colors.white.withOpacity(0.7),
                      child: Container(
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(children: [Text(title)]),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }

  _launchURL(link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Row servicesList(String image1, image2, title1, title2) {
    return Row(
      children: [
        Expanded(
          child: ScaleTap(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Image.asset(
                      image1,
                      scale: 1.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(title1),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [shadowList()],
              ),
            ),
            onPressed: () {
              Navigator.restorablePushNamed(context, Booking1Screen.routeName);
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Image.asset(
                      image2,
                      scale: 1.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(title2),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
