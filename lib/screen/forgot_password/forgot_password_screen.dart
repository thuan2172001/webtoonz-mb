import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/reset_password/reset_password_controller.dart';
import 'package:untitled/screen/forgot_password/check_email_screen.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/app_name.dart';
import 'package:untitled/widgets/dialog.dart';
import 'package:untitled/widgets/input.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ResetPasswordController forgotPasswordController =
      Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: getHeight(12)),
          child: confirmButtonContainer(context, forgotPasswordController)),
      appBar: appBar(
        title: "",
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
          left: getWidth(24),
          right: getWidth(24),
          top: getHeight(62),
        ),
        child: Column(
          children: [
            getAppName(),
            SizedBox(
              height: getHeight(12),
            ),
            Text(
              "We will sent you an active code to reset your password. Please enter your email address you have registered for our system",
              style: TextStyle(
                fontSize: getHeight(13),
                color: const Color(0xff999999),
                height: getHeight(2),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(30),
            ),
            inputRegular(
              context,
              label: "email".tr,
              hintText: "name@email.com",
              textEditingController: forgotPasswordController.email,
            ),
            SizedBox(
              height: getHeight(12),
            ),
          ],
        ),
      ),
    );
  }
}

Container layout({required Widget child}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: getHeight(46),
      left: getWidth(16),
      right: getWidth(16),
    ),
    height: getHeight(48),
    width: double.infinity,
    child: child,
  );
}

Container confirmButtonContainer(
    BuildContext context, ResetPasswordController controller) {
  return layout(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF3669C9),
              side: const BorderSide(
                color: Color(0xFF3669C9),
              ),
            ),
            onPressed: () async {
              var status = await controller.forgotPassword(context);
              if (status) Get.to(() => ForgotPasswordCheckEmailScreen());
            },
            child: Text("continue".tr,
                style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}
