import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:untitled/controller/transaction/transaction_controller.dart';
import 'package:untitled/screen/transaction/transaction_card.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';

class TransactionScreen extends StatelessWidget {
  String shortenTransactionID(String id) {
    return "${id.substring(0, 3)}-${id.substring(id.length - 3)}";
  }

  String shortenDate(String date) {
    return date.substring(0, 10);
  }

  List<String> getEpisodes(List input) {
    List<String> result = List.empty(growable: true);
    input.forEach((element) => result.add(element.toString()));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    TransactionController transactionController =
        Get.put(TransactionController());
    var ratio =
        transactionController.totalTransaction / transactionController.limit;
    var numberOfPages =
        ratio > ratio.floor() ? ratio.floor() + 1 : ratio.floor();
    numberOfPages = max(numberOfPages, 1);

    return FutureBuilder(
        future: transactionController.getTransactions(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: appBar(
                title: "Transaction",
                centerTitle: true,
              ),
              body: Container(
                color: Color(0xF6F6F6),
                margin: EdgeInsets.only(
                    left: getWidth(27),
                    right: getWidth(27),
                    top: getHeight(20),
                    bottom: getHeight(20)),
                width: double.infinity,
                height: double.infinity,
                child: Obx(
                  () => ListView(
                    children:
                        transactionController.transactions.map((transaction) {
                      return TransactionCard(
                        transactionID:
                            shortenTransactionID(transaction["transactionId"]),
                        date: shortenDate(transaction["createdAt"]),
                        amount: transaction["value"].toString(),
                        episodes: getEpisodes(transaction["items"]),
                      );
                    }).toList(),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(bottom: getHeight(4)),
                child: NumberPaginator(
                  numberPages: numberOfPages,
                  initialPage: 0,
                  onPageChange: (index) {
                    transactionController.getTransactions(index + 1);
                  },
                  buttonShape: CircleBorder(
                      side: BorderSide(width: 1, color: Colors.transparent)),
                  buttonSelectedForegroundColor: Colors.white,
                  buttonSelectedBackgroundColor: Colors.blue,
                  buttonUnselectedForegroundColor: Colors.white,
                  buttonUnselectedBackgroundColor: Colors.transparent,
                ),
              ),
            );
          } else if (snapshot.hasError)
            return Column(
              children: [
                Text(
                  snapshot.error.toString(),
                ),
              ],
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
