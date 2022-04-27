import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/signup/signup_controller.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/signup/signup_creator_screen.dart';
import 'package:untitled/screen/signup/signup_customer_screen.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_name.dart';
import 'package:untitled/widgets/layout.dart';

class SignupWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignupController signupController = Get.put(SignupController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: getHeight(0)),
          child: confirmButtonContainer(context, signupController)),
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
              height: getHeight(24),
            ),
            Text(
              "Sign up",
              style: TextStyle(
                fontSize: getHeight(20),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(36),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFFE6E6E6),
                  ),
                  padding: EdgeInsets.symmetric(vertical: getHeight(16))),
              onPressed: () {
                signupController.isCustomerMode.value = true;
                Get.to(() => SignupCustomerScreen());
              },
              child: const Text(
                "Create account as Customer",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: getHeight(8),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFFE6E6E6),
                  ),
                  padding: EdgeInsets.symmetric(vertical: getHeight(16))),
              onPressed: () {
                signupController.isCustomerMode.value = false;
                Get.to(() => SignupCreatorScreen());
              },
              child: const Text(
                "Create account as Creator",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container confirmButtonContainer(
    BuildContext context, SignupController signupController) {
  return bottomContainerLayout(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Get.to(() => LoginScreen());
            },
            child: const Text(
              "Already have account? Back to Sign-in",
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
