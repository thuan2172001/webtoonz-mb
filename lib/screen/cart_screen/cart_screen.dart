import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/cart/cart_controller.dart';
import 'package:untitled/screen/cart_screen/cart_screen_component.dart';
import 'package:untitled/widgets/app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: appBar(
        centerTitle: true,
        title: "Orders",
        hideBackButton: true,
      ),
      body: Container(
        child: Obx(() {
            return ListView(
              children: List.generate(
                cartController.episodeList.length,
                (index) => OrderItem(
                  episode: cartController.episodeList[index],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
