import 'package:flutter/cupertino.dart';

class TestPage extends StatelessWidget {
  final int totalPrice;
  const TestPage({Key? key, required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(totalPrice.toString()),
    );
  }
}
