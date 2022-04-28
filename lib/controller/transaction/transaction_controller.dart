import 'dart:convert';

import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/model/custom_dio.dart';

class TransactionController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());
  RxList transactions = List.empty(growable: true).obs;

  @override
  void onInit() async {
    super.onInit();
    await getTransactions();
  }

  Future getTransactions() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio
          .get("/user/${globalController.user.value.id}/transaction");
      response = jsonDecode(response.toString());
      var data = response["data"]["data"] ?? [];
      transactions.value = [1, 2, 3];
    } catch (e, s) {
      return null;
    }
  }
}
