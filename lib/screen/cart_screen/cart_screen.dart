import 'package:flutter/material.dart';
import 'package:untitled/screen/cart_screen/cart_screen_component.dart';
import 'package:untitled/widgets/app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(centerTitle: true, title: "Orders"),
      body: Container(
        child: ListView(
          children: [
            OrderItem(),
            OrderItem(),
          ],
        ),
      ),
    );
  }
}
