import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

enum SingingCharacter { creditCard, paypal, googlePay }

class _BodyState extends State<Body> {
  SingingCharacter? _character = SingingCharacter.creditCard;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [shadowList()]),
              child: ListTile(
                title: const Text('Credit Card'),
                trailing: const Icon(Iconsax.card),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.creditCard,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [shadowList()]),
              child: ListTile(
                title: const Text('PayPal'),
                trailing: const Icon(Iconsax.card),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.paypal,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [shadowList()]),
              child: ListTile(
                title: const Text('Google Pay'),
                trailing: const Icon(Iconsax.card),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.googlePay,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
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
