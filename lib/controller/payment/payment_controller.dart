import 'package:get/get.dart';
import 'package:untitled/model/PaymentMethod.dart';

class PaymentController extends GetxController {
  RxList<PaymentMethod> paymentMethods = <PaymentMethod>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void addPaymentMethod(PaymentMethod paymentMethod) {
    paymentMethods.add(paymentMethod);
    paymentMethods.refresh();
  }

  void deletePaymentMethod(int index) {
    paymentMethods.removeAt(index);
    paymentMethods.refresh();
  }
}
