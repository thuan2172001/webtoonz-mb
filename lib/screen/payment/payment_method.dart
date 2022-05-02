import 'package:flutter/material.dart';
import 'package:untitled/widgets/app_bar.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Payment methods", centerTitle: true),
      body: Column(
        children: [
          Text("Your payment cards"),
          ListView(
            children: [],
          )
        ],
      ),
    );
  }
}
