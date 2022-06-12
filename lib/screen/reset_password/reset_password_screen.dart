import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/reset_password/reset_password_controller.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/reset_password/reset_success_screen.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/app_name.dart';
import 'package:untitled/widgets/dialog.dart';
import 'package:untitled/widgets/input.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordController forgotPasswordController =
      Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: getHeight(12)),
      ),
      appBar: appBar(title: "Reset password", centerTitle: true),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
          left: getWidth(24),
          right: getWidth(24),
          top: getHeight(24),
        ),
        child: Column(
          children: [
            inputRegular(context,
                label: "email_or_phone".tr,
                hintText: "name@email.com",
                enabled: false,
                textEditingController: forgotPasswordController.email),
            SizedBox(height: getHeight(16)),
            Obx(() => inputPassword(
                  context,
                  label: "password".tr,
                  controller: forgotPasswordController.password,
                  hintText: "Enter your password",
                  isHide: forgotPasswordController.isHidePassword.value,
                  changeHide: forgotPasswordController.changeHidePassword,
                )),
            SizedBox(height: getHeight(16)),
            inputRegular(
              context,
              label: "Active code".tr,
              textEditingController: forgotPasswordController.code,
              hintText: "Enter your code",
            ),
            SizedBox(height: getHeight(16)),
            Container(
              height: getHeight(48),
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFF3669C9),
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () async {
                  var status =
                      await forgotPasswordController.resetPassword(context);
                  if (status) {
                    Get.delete<ResetPasswordController>();
                    Get.to((ResetSuccessScreen()));
                  }
                },
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
