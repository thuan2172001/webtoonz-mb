import 'dart:convert';

import 'package:get/get.dart';
import 'package:untitled/utils/common-function.dart';

import '../../main.dart';
import '../../model/custom_dio.dart';

class SalesController extends GetxController {
  late List<MonthNumberPair> monthSales;
  late List<MonthNumberPair> createdEpisodes;
  late List<MonthNumberPair> createdSeries;
  late int maxSales;
  late int maxCreatedEpisodes;
  late int maxCreatedSeries;

  Future getSales() async {
    CustomDio customDio = CustomDio();
    customDio.dio.options.headers["Authorization"] =
        globalController.user.value.certificate.toString();
    var response = await customDio.get("/creator/sales");
    response = jsonDecode(response.toString());
    var sales = response["data"]["monthSales"];
    monthSales = List.generate(
        sales.length,
        (index) => MonthNumberPair(
            getSalesMonth(sales[index]["monthName"], sales[index]["year"]),
            sales[index]["totalSale"]));
    createdEpisodes = List.generate(
        sales.length,
        (index) => MonthNumberPair(
            getSalesMonth(sales[index]["monthName"], sales[index]["year"]),
            int.parse(sales[index]["createdEpisodes"])));
    createdSeries = List.generate(
        sales.length,
        (index) => MonthNumberPair(
            getSalesMonth(sales[index]["monthName"], sales[index]["year"]),
            int.parse(sales[index]["createdSeries"])));
    maxSales = monthSales
        .reduce((curr, next) => curr.total > next.total ? curr : next)
        .total;
    if (maxSales < 100) maxSales = 100;
    maxCreatedEpisodes = createdEpisodes
        .reduce((curr, next) => curr.total > next.total ? curr : next)
        .total;
    if (maxCreatedEpisodes < 100) maxCreatedEpisodes = 100;
    maxCreatedSeries = createdSeries
        .reduce((curr, next) => curr.total > next.total ? curr : next)
        .total;
    if (maxCreatedSeries < 100) maxCreatedSeries = 100;
  }
}

class MonthNumberPair {
  String month = "";
  int total = 0;

  MonthNumberPair(String _month, int _total) {
    month = _month;
    total = _total;
  }

  @override
  String toString() {
    return "{month: $month, total: $total}";
  }
}
