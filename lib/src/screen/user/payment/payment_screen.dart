import 'package:dingo_clean/src/default_button.dart';
import 'package:dingo_clean/src/screen/user/receipt/receipt_screen.dart';
import 'package:dingo_clean/src/theme_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/constant.dart';
import 'package:dingo_clean/src/controller/paypal_payment.dart';
import 'package:dingo_clean/src/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  final int totalPrice;
  const PaymentScreen({Key? key, required this.totalPrice}) : super(key: key);
  static const routeName = '/payment';
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum SingingCharacter { creditCard, paypal }

class _PaymentScreenState extends State<PaymentScreen> {
  String userID = '';
  final firestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  SingingCharacter? _character = SingingCharacter.creditCard;
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: ThemeAppBar(
          "Payment Option",
          color: Colors.transparent,
          primaryBg: false,
        ),
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
                              totalPrice: widget.totalPrice,
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
          await createPaymentIntent(0, 'MYR'); //json.decode(response.body);
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
  createPaymentIntent(int totalPrice, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(widget.totalPrice),
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

  calculateAmount(int totalPrice) {
    final a = widget.totalPrice * 100;
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
            .showSnackBar(const SnackBar(content: Text("Paid successfully")));
        updateStatus();
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

  Future<void> updateStatus() async {
    User? getUser = FirebaseAuth.instance.currentUser;
    userID = getUser!.uid;

    //Update booking collection
    var collection = FirebaseFirestore.instance
        .collection('booking')
        .doc(userID)
        .collection("service");
    var querySnapshots = await collection.orderBy("Order created at",descending: true).limit(1).get();

    //Update bookingAdmin collection
    var adminCollection = FirebaseFirestore.instance.collection('bookingAdmin');

    var queryAdmin = await collection.get();
    for (var snapshot in queryAdmin.docs) {
      var documentID = snapshot.id; // <-- Document ID
      adminCollection.doc(documentID).update({
        "Payment status": "Paid",
      });
    }
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      collection.doc(documentID).update({
        "Payment status": "Paid",
      }).then((value) {
        print("Successfully update payment status");
        Navigator.restorablePushNamed(context, ReceiptScreen.routeName);
      });
    }
  }
}
