import 'package:floating_pullup_card/floating_pullup_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/controller/payment/payment_controller.dart';
import 'package:untitled/model/PaymentMethod.dart';
import 'package:untitled/screen/payment/payment_method.dart';
import 'package:untitled/screen/payment/success_screen.dart';

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
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return FloatingPullUpCardLayout(
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
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  primary: const Color(0xff1b447b),
                ),
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: const Text(
                    'Add New Card',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'halter',
                      fontSize: 14,
                      package: 'flutter_credit_card',
                    ),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.addPaymentMethod(PaymentMethod(cardHolderName,
                        cardNumber, expiryDate, cvvCode, false));
                    Get.to(() => AddPaymentSuccessScreen());
                  } else {
                    print("invalid");
                  }
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                primary: const Color(0xff1b447b),
              ),
              child: Container(
                margin: const EdgeInsets.all(12),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'halter',
                    fontSize: 14,
                    package: 'flutter_credit_card',
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
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
