import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/transaction/transaction_controller.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransactionController transactionController =
        Get.put(TransactionController());

    return Scaffold(
      appBar: appBar(
        title: "Transaction",
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xF6F6F6),
        padding: EdgeInsets.only(
            left: getWidth(27), right: getWidth(27), top: getHeight(20)),
        width: double.infinity,
        height: double.infinity,
        child: Obx(
          () => ListView(
            children: transactionController.transactions.map((e) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  vertical: getHeight(24),
                ),
                margin: EdgeInsets.symmetric(
                  vertical: getHeight(10),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
                  child: Column(children: [
                    Row(
                      children: [
                        Text("Order 423121"),
                        Spacer(), // use Spacer
                        Text("2"),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(15),
                    ),
                    Row(
                      children: [
                        Text("Episode ID"),
                        Spacer(), // use Spacer
                        Text("IW3475453455"),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(15),
                    ),
                    Row(
                      children: [
                        Text("Total Amount:"),
                        Spacer(), // use Spacer
                        Text("112 USD"),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(15),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                      height: getHeight(48),
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.black),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Enjoy",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
