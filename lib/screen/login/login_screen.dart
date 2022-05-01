import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/controller/login/login_controller.dart';
import 'package:untitled/screen/home_page/home_page_screen.dart';
import 'package:untitled/screen/signup/signup_welcome_screen.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/bounce_button.dart';
import 'package:untitled/widgets/input.dart';
import 'package:untitled/widgets/app_name.dart';
import 'package:untitled/widgets/layout.dart';

import '../episode_detail/episode_detail_screen.dart';

enum LoginOption { customer, professional }

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginPageController loginPageController = Get.put(LoginPageController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: getHeight(0)),
          child: confirmButtonContainer(context, loginPageController)),
      body: Container(
        padding: EdgeInsets.only(
          left: getWidth(16),
          right: getWidth(16),
          top: getHeight(62),
        ),
        color: Colors.white,
        child: ListView(
          children: [
            getAppName(),
            SizedBox(
              height: getHeight(24),
            ),
            Text(
              'welcomeBack'.tr,
              style: TextStyle(
                fontSize: getHeight(24),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(4),
            ),
            Text(
              "Sign in to your account",
              style: TextStyle(
                fontSize: getHeight(16),
                color: const Color(0xff999999),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(40),
            ),
            inputRegular(context,
                label: "email_or_phone".tr,
                hintText: "name@email.com",
                textEditingController: loginPageController.username),
            Obx(
              () => loginPageController.messValidateUsername.value != ""
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: getHeight(12),
                          bottom: getHeight(12),
                          left: getWidth(16)),
                      child: InkWell(
                        child: Text(
                          loginPageController.messValidateUsername.value.tr,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {},
                      ),
                    )
                  : SizedBox(
                      height: getHeight(12),
                    ),
            ),
            Obx(() => inputPassword(
                  context,
                  label: "password".tr,
                  controller: loginPageController.password,
                  hintText: "Enter your password",
                  isHide: loginPageController.isHidePassword.value,
                  changeHide: loginPageController.changeHidePassword,
                )),
            Obx(
              () => loginPageController.messValidatePassword.value != ""
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: getHeight(12),
                          bottom: getHeight(12),
                          left: getWidth(16)),
                      child: InkWell(
                        child: Text(
                          loginPageController.messValidatePassword.value.tr,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {},
                      ),
                    )
                  : SizedBox(
                      height: getHeight(12),
                    ),
            ),
            Bouncing(
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPress: () => {}),
          ],
        ),
      ),
    );
  }
}

Container confirmButtonContainer(
    BuildContext context, LoginPageController controller) {
  GlobalController globalController = Get.put(GlobalController());
  return bottomContainerLayout(
    height: 120,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(
          () => Expanded(
            child: controller.isLoading.value == true
                ? Container(
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFF3669C9),
                      side: const BorderSide(
                        color: Color(0xFF3669C9),
                      ),
                    ),
                    onPressed: () async {
                      // controller.isLoading.value = true;
                      var result = await controller.login();
                      if (result) {
                        Get.to(() => HomePageScreen());
                        //Get.to(() => HomePageScreen());
                      }
                      controller.isLoading.value = false;
                    },
                    child: const Text("Sign in",
                        style: TextStyle(color: Colors.white)),
                  ),
          ),
        ),
        SizedBox(
          height: getHeight(12),
        ),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Get.to(SignupWelcomeScreen());
            },
            child: const Text(
              "Don't have account? Create new",
              style: TextStyle(
                color: Color(0xFF3669C9),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
