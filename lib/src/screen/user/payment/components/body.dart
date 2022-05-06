import 'dart:convert';

import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/controller/paypal_payment.dart';
import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/receipt/receipt_screen.dart';
import 'package:dingo_clean/src/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pay/pay.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

enum SingingCharacter { creditCard, paypal }

class _BodyState extends State<Body> {
  SingingCharacter? _character = SingingCharacter.creditCard;
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: DefaultButton(
              title: "Pay Now",
              color: primaryColor,
              press: () {
                setState(() {
                  switch (_character) {
                    case SingingCharacter.creditCard:
                      makeCardPayment();
                      break;
                    case SingingCharacter.paypal:
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PaypalPayment(
                              onFinish: (number) async {
                                // payment done
                                print('order id: ' + number);
                              },
                            ),
                          ),
                        );
                      });
                      break;
                    case null:
                  }
                });
              }),
        ));
  }

  BoxShadow shadowList() {
    return BoxShadow(
      blurRadius: 6,
      spreadRadius: 5,
      offset: const Offset(4, 4),
      color: Colors.black.withOpacity(0.2),
    );
  }

  Future<void> makeCardPayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('0', 'MYR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'AFIF'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Ku7LCEj4onVUXNay6uGogL5TDcQZdFDRvPZ1CC7qUL4lYd790Q4nQjswCCXmqnfEV81lfUcs3696gjumPiCAzxv002ztSVt91',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }
}
