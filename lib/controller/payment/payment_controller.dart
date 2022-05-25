import 'dart:convert';

import 'package:get/get.dart';
import 'package:untitled/model/PaymentCard.dart';
import 'package:untitled/utils/common-function.dart';

import '../../main.dart';
import '../../model/custom_dio.dart';

class PaymentController extends GetxController {
  RxList<PaymentCard> paymentMethods = <PaymentCard>[].obs;

  RxBool isPickCard = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchPaymentMethods();
  }

  Future fetchPaymentMethods() async {
    CustomDio customDio = CustomDio();
    customDio.dio.options.headers["Authorization"] =
        globalController.user.value.certificate.toString();
    var response = await customDio.get("/payment");
    response = jsonDecode(response.toString());
    var paymentData = response["data"];
    paymentMethods.value = List.generate(paymentData.length, (index) {
      bool defaultPayment = false;
      if (index == 0) defaultPayment = true;
      return PaymentCard(
          paymentData[index]["paymentId"],
          paymentData[index]["nameOnCard"],
          paymentData[index]["card"]["card"]["last4"] +
              "00000000" +
              paymentData[index]["card"]["card"]["last4"],
          getExpireDate(paymentData[index]["card"]["card"]["exp_month"],
              paymentData[index]["card"]["card"]["exp_year"]),
          "123",
          defaultPayment);
    });
    paymentMethods.refresh();
  }
}
