import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:untitled/model/custom_dio.dart';
import 'package:untitled/widgets/dialog.dart';

class StripeService {
  static Future<String> getPubKey() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.get("/user/api-key");
      var json = jsonDecode(response.toString());
      return json["data"]["apiKey"];
    } catch (e, s) {
      print(e);
      return "";
    }
  }

  static Future<SetupIntent?> createSetupIntent(CardDetails _card) async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.get("/payment/create-setup-intent");
      var json = jsonDecode(response.toString());

      var publishedKey = await getPubKey();
      Stripe.publishableKey = publishedKey;

      await Stripe.instance.dangerouslyUpdateCardDetails(_card);
      const billingDetails =
          BillingDetails(email: "thuan2172001@gmail.com", phone: "0337336033");

      var paymentMethod = await Stripe.instance.createPaymentMethod(
          const PaymentMethodParams.card(billingDetails: billingDetails));

      PaymentMethodParams params = PaymentMethodParams.cardFromMethodId(
          paymentMethodId: paymentMethod.id, cvc: _card.cvc);

      SetupIntent confirmPayment = await Stripe.instance
          .confirmSetupIntent(json["data"]["client_secret"], params);

      return confirmPayment;
    } catch (e, s) {
      print(e);
      return null;
    }
  }

  static Future createNewPayment(SetupIntent? paymentMethod,
      BuildContext context, String cardHolder) async {
    try {
      if (paymentMethod == null) {
        return;
      }
      CustomDio customDio = CustomDio();
      var response = await customDio.post("/payment", {
        "nameOnCard": cardHolder,
        "futureUsage": true,
        "paymentMethodInfo": {
          "payment_method": paymentMethod.paymentMethodId,
          "status": "succeeded"
        }
      });
      var json = jsonDecode(response.toString());
      return json["data"];
    } catch (e, s) {
      CustomDialog(context, "FAILED").show({"message": e.toString()});
      return null;
    }
  }

  static Future deletePayment(
      String paymentMethodId, BuildContext context) async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.delete("/payment/$paymentMethodId");
      var json = jsonDecode(response.toString());
      print(json["data"]);
      return json["data"];
    } catch (e, s) {
      CustomDialog(context, "FAILED").show({"message": e.toString()});
      return null;
    }
  }
}
