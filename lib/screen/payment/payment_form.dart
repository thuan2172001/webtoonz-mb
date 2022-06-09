import 'package:floating_pullup_card/floating_pullup_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tuple/tuple.dart';
import 'package:untitled/controller/payment/payment_controller.dart';
import 'package:untitled/screen/payment/payment_method.dart';
import 'package:untitled/screen/payment/success_screen.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/dialog.dart';

import '../../main.dart';
import '../../model/custom_dio.dart';
import '../../service/stripe.dart';
import '../../utils/common-function.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({Key? key}) : super(key: key);

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: FloatingPullUpCardLayout(
          withOverlay: true,
          state: FloatingPullUpState.uncollapsed,
          child: PaymentMethodScreen(),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: CreditCardForm(
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  onCreditCardModelChange: onCreditCardModelChange,
                  themeColor: Colors.white,
                  cardNumber: cardNumber,
                  formKey: formKey,
                  cvvCode: cvvCode,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    primary: Color.fromARGB(255, 69, 125, 198),
                  ),
                  icon: isLoading
                      ? Container(
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.all(2.0),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Icon(Icons.add),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() => isLoading = true);
                      CustomDio customDio = CustomDio();
                      customDio.dio.options.headers["Authorization"] =
                          globalController.user.value.certificate.toString();
                      Tuple2 date = extractDate(expiryDate);
                      var card = CardDetails.fromJson({
                        "number": cardNumber,
                        "expirationYear": date.item2,
                        "expirationMonth": date.item1,
                        "cvc": cvvCode
                      });
                      var paymentMethod =
                          await StripeService.createSetupIntent(card);
                      var response = await StripeService.createNewPayment(
                          paymentMethod, context, cardHolderName, card);
                      if (response == null) {
                        setState(() => isLoading = false);
                        CustomDialog(context, "FAILED")
                            .show({"message": "Add card failed !"});
                        return;
                      }
                      await controller.fetchPaymentMethods();
                      Get.to(() => AddPaymentSuccessScreen());
                    } else {
                      print("invalid");
                    }
                  },
                  label: const Text(
                    'Add New Card',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      package: 'flutter_credit_card',
                    ),
                  ),
                ),
                SizedBox(
                  width: getWidth(10),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    primary: Color.fromARGB(255, 69, 125, 198),
                  ),
                  child: Container(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        package: 'flutter_credit_card',
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                )
              ]),
            ],
          )),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      //isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
