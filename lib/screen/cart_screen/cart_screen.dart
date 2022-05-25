import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/cart/cart_controller.dart';
import 'package:untitled/controller/payment/payment_controller.dart';
import 'package:untitled/screen/cart_screen/cart_screen_component.dart';
import 'package:untitled/screen/payment/payment_method.dart';
import 'package:untitled/screen/payment/success_screen.dart';
import 'package:untitled/utils/config.dart';
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
        child: ListView(
          children: [
            Obx(() {
              return Column(
                children: List.generate(
                  cartController.episodeList.length,
                  (index) => OrderItem(
                    episode: cartController.episodeList[index],
                  ),
                ),
              );
            }),
            SizedBox(
              height: getHeight(25),
            ),
            Container(
              padding: EdgeInsets.only(
                left: getWidth(21),
                right: getWidth(21),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment",
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.put(PaymentController()).isPickCard.value = true;
                          Get.to(PaymentMethodScreen());
                        },
                        child: Text(
                          "Change",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getHeight(18),
                  ),
                  Obx(() {
                    return cartController.cardId.value != ""
                        ? Row(
                            children: [
                              Container(
                                width: getWidth(64),
                                height: getHeight(38),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              SizedBox(
                                width: getWidth(18),
                              ),
                              Text(cartController.cardNumber.replaceAll(
                                  RegExp(r'(?<=.{0})\d(?=.{4})'), '*'))
                            ],
                          )
                        : SizedBox();
                  }),
                  SizedBox(
                    height: getHeight(27),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Items",
                      ),
                      Obx(() {
                        return Text(
                          "${cartController.episodeList.length}",
                        );
                      })
                    ],
                  ),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment",
                      ),
                      Obx(() {
                        return Text(
                          "${cartController.episodeList.length > 0 ? cartController.episodeList.reduce((previousValue, element) {
                              element.price += previousValue.price;
                              return element;
                            }).price : 0}\$",
                        );
                      })
                    ],
                  ),
                  SizedBox(
                    height: getHeight(23),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        primary: Color.fromARGB(255, 63, 104, 154),
                        fixedSize: Size(
                          350,
                          50,
                        )),
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          package: 'flutter_credit_card',
                        ),
                      ),
                    ),
                    onPressed: () async {
                      var res = await cartController.checkout();
                      if (res) {
                        Get.to(AddPaymentSuccessScreen());
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
