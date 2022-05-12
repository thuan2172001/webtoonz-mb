import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/signup/signup_controller.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/signup/verified-page.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/dialog.dart';
import 'package:untitled/widgets/input.dart';
import 'package:untitled/widgets/app_name.dart';
import 'package:untitled/widgets/layout.dart';

class SignupCreatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignupController signupController = Get.put(SignupController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: Padding(
      //     padding: EdgeInsets.only(top: getHeight(0)),
      //     child: confirmButtonContainer(context, signupController)),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: getWidth(16),
          right: getWidth(16),
          top: getHeight(24),
        ),
        child: ListView(
          children: [
            getAppName(),
            SizedBox(
              height: getHeight(20),
            ),
            Text(
              "Creator - Sign up",
              style: TextStyle(
                fontSize: getHeight(20),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(4),
            ),
            inputRegular(
              context,
              label: "email".tr,
              hintText: "name@email.com",
              required: true,
              textEditingController: signupController.email,
            ),
            SizedBox(
              height: getHeight(4),
            ),
            inputRegular(
              context,
              label: "fullName".tr,
              textEditingController: signupController.fullName,
              hintText: "Enter your name",
            ),
            SizedBox(
              height: getHeight(4),
            ),
            inputRegular(
              context,
              label: "phone".tr,
              hintText: "Enter your phone",
              required: true,
              textEditingController: signupController.phoneNumber,
            ),
            SizedBox(
              height: getHeight(4),
            ),
            Obx(() => inputPassword(
                  context,
                  label: "password".tr,
                  controller: signupController.password,
                  hintText: "Enter your password",
                  isHide: signupController.isHidePassword.value,
                  changeHide: signupController.changeHidePassword,
                  required: true,
                )),
            SizedBox(
              height: getHeight(4),
            ),
            Obx(() => inputPassword(
                  context,
                  label: "cfPassword".tr,
                  controller: signupController.confirmPassword,
                  hintText: "Enter your password",
                  required: true,
                  isHide: signupController.isHideCfPassword.value,
                  changeHide: signupController.changeHideCfPassword,
                )),
            SizedBox(
              height: getHeight(4),
            ),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                      value: signupController.isAgree.value,
                      onChanged: (bool? value) {
                        signupController.isAgree.value = value ?? false;
                      }),
                ),
                Text(
                  "I agree to the ",
                  style: TextStyle(
                      fontSize: getHeight(14), fontWeight: FontWeight.w500),
                ),
                Text(
                  "Term of Use and Policy",
                  style: TextStyle(
                      fontSize: getHeight(14),
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3864FF),
                      decoration: TextDecoration.underline),
                ),
              ],
            ),
            confirmButtonContainer(context, signupController),
          ],
        ),
      ),
    );
  }
}

Widget confirmButtonContainer(
    BuildContext context, SignupController signupController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFF3669C9),
          side: const BorderSide(
            color: Color(0xFF3669C9),
          ),
          padding: EdgeInsets.symmetric(vertical: getHeight(14)),
        ),
        onPressed: () async {
          if (signupController.email.text != "" &&
              signupController.password.text != "" &&
              signupController.isAgree.value == true &&
              signupController.confirmPassword.text != "") {
            var result = await signupController.signupCreator();
            if (result["success"] == true) {
              Get.to(() => VerifiedPage());
            } else {
              CustomDialog(context, "FAILED")
                  .show({"message": result["reason"] ?? "SIGNUP_FAILED"});
            }
          }
        },
        child: Text("continue".tr, style: const TextStyle(color: Colors.white)),
      ),
      SizedBox(
        height: getHeight(4),
      ),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Get.offAll(() => LoginScreen());
        },
        child: const Text(
          "Already have account? Back to Sign-in",
          style: TextStyle(
            color: Color(0xFF3669C9),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
