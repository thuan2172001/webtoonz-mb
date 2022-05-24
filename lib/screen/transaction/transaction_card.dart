import 'package:flutter/material.dart';
import 'package:untitled/utils/common-function.dart';

import '../../utils/config.dart';

class TransactionCard extends StatelessWidget {
  final String amount;
  final String date;
  final String transactionID;
  final List<String> episodes;

  const TransactionCard(
      {Key? key,
      required this.amount,
      required this.date,
      required this.transactionID,
      required this.episodes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text("Order $transactionID"),
              Spacer(),
              Text(date) // use Spacer
            ],
          ),
          SizedBox(
            height: getHeight(15),
          ),
          Row(
            children: [
              Text("Episode ID"),
              Spacer(), // use Spacer
              Text(shortenID(episodes[0])),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: List.generate(episodes.length - 1,
                  (index) => Text(shortenID(episodes[index + 1]))),
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
          SizedBox(
            height: getHeight(15),
          ),
          Row(
            children: [
              Text("Total Amount:"),
              Spacer(), // use Spacer
              Text("$amount\$"),
            ],
          ),
          SizedBox(
            height: getHeight(15),
          ),
        ]),
      ),
    );
  }
}
