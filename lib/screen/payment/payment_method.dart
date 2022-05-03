import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/controller/payment/payment_controller.dart';
import 'package:untitled/screen/payment/payment_form.dart';
import 'package:untitled/widgets/app_bar.dart';

class PaymentMethodScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Payment methods", centerTitle: true),
      body: Padding(
        padding: EdgeInsets.only(top: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 3.h, left: 10),
              child: Text(
                "Your payment cards",
                style: TextStyle(fontSize: 10.sp),
              ),
            ),
            Obx(() => ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 76.h),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.paymentMethods.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          CreditCardWidget(
                            cardNumber:
                                controller.paymentMethods[index].cardNumber,
                            expiryDate:
                                controller.paymentMethods[index].expireDate,
                            cardHolderName:
                                controller.paymentMethods[index].cardHolder,
                            cvvCode: controller.paymentMethods[index].cvv,
                            showBackView: false,
                            onCreditCardWidgetChange: (CreditCardBrand) {},
                            obscureCardNumber: true,
                            obscureCardCvv: true,
                            isHolderNameVisible: true,
                            cardBgColor: Colors.black,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 10.sp,
                                ),
                                onPressed: () {
                                  controller.deletePaymentMethod(index);
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => PaymentForm());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
