import 'dart:convert';

import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/model/custom_dio.dart';

class TransactionController extends GetxController {
  int limit = 8;
  int totalTransaction = 0;
  GlobalController globalController = Get.put(GlobalController());
  RxList transactions = List.empty(growable: true).obs;

  @override
  void onInit() async {
    super.onInit();
    //await getTransactions(1);
  }

  Future getTransactions(int page) async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.get(
          "/user/${globalController.user.value.id}/transaction?limit=$limit&page=$page");
      response = jsonDecode(response.toString());
      var data = response["data"]["data"] ?? [];
      var total = response["data"]["total"] ?? 0;
      transactions.value = data;
      totalTransaction = total;
      transactions.refresh();
      //transactions.value = [1, 2, 3];
    } catch (e, s) {
      return null;
    }
  }
}
