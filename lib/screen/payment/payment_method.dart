import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/controller/cart/cart_controller.dart';
import 'package:untitled/controller/payment/payment_controller.dart';
import 'package:untitled/screen/payment/payment_form.dart';
import 'package:untitled/widgets/app_bar.dart';

import '../../service/stripe.dart';

class PaymentMethodScreen extends StatefulWidget {
  PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final PaymentController controller = Get.put(PaymentController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double listViewHeight =
        MediaQuery.of(context).orientation == Orientation.portrait ? 76 : 30;
    return AbsorbPointer(
      absorbing: isLoading,
      child: Scaffold(
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
                    constraints: BoxConstraints(maxHeight: listViewHeight.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.paymentMethods.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CreditCardWidget(
                                  cardNumber: controller
                                      .paymentMethods[index].cardNumber,
                                  expiryDate: controller
                                      .paymentMethods[index].expireDate,
                                  cardHolderName: controller
                                      .paymentMethods[index].cardHolder,
                                  cvvCode: controller.paymentMethods[index].cvv,
                                  showBackView: false,
                                  onCreditCardWidgetChange:
                                      (CreditCardBrand) {},
                                  obscureCardNumber: true,
                                  obscureCardCvv: true,
                                  isHolderNameVisible: true,
                                  cardBgColor: Colors.black,
                                  backgroundImage: 'assets/images/card_bg.png',
                                ),
                                controller.isPickCard.value
                                    ? SizedBox()
                                    : Align(
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
                                              String alertCardNumber = controller
                                                  .paymentMethods[index]
                                                  .cardNumber
                                                  .replaceAll(
                                                      RegExp(
                                                          r'(?<=.{0})\d(?=.{4})'),
                                                      '*');
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                            title: Text(
                                                                "Delete payment method?"),
                                                            content: Text(
                                                                "Are you sure you want to delete card $alertCardNumber?"),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Cancel'),
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  setState(() =>
                                                                      isLoading =
                                                                          true);
                                                                  await StripeService.deletePayment(
                                                                      controller
                                                                          .paymentMethods[
                                                                              index]
                                                                          .paymentId,
                                                                      context);
                                                                  await controller
                                                                      .fetchPaymentMethods();
                                                                  Navigator.pop(
                                                                      context,
                                                                      'OK');
                                                                  setState(() =>
                                                                      isLoading =
                                                                          false);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'OK'),
                                                              ),
                                                            ],
                                                          ));
                                            },
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            Obx(() {
                              return controller.isPickCard.value
                                  ? Row(
                                      children: [
                                        Obx(() {
                                          return Checkbox(
                                            activeColor: Colors.black,
                                            checkColor: Colors.white,
                                            value: Get.put(CartController())
                                                    .cardId
                                                    .value ==
                                                controller.paymentMethods[index]
                                                    .paymentId,
                                            onChanged: (value) {
                                              if (value == true) {
                                                Get.put(CartController())
                                                        .cardId
                                                        .value =
                                                    controller
                                                        .paymentMethods[index]
                                                        .paymentId;
                                                Get.put(CartController())
                                                        .cardNumber
                                                        .value =
                                                    controller
                                                        .paymentMethods[index]
                                                        .cardNumber;
                                              }
                                            },
                                          );
                                        }),
                                        Text("Use this card"),
                                      ],
                                    )
                                  : SizedBox();
                            }),
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
      ),
    );
  }
}
