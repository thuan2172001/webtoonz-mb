import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/reset_password/reset_password_controller.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/reset_password/reset_password_screen.dart';
import 'package:untitled/utils/common-function.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_name.dart';
import 'package:untitled/widgets/bounce_button.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ForgotPasswordCheckEmailScreen extends StatelessWidget {
  ResetPasswordController forgotPasswordController =
      Get.put(ResetPasswordController());
  CountdownController countdownController =
      CountdownController(autoStart: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: getHeight(12)),
          child: confirmButtonContainer(context)),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF454B52),
            ),
            onPressed: () {
              Get.back();
            }),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
          left: getWidth(24),
          right: getWidth(24),
          top: getHeight(24),
        ),
        child: Column(
          children: [
            getAppName(),
            SizedBox(
              height: getHeight(38),
            ),
            Container(
              height: getHeight(120),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/mail_sending.png'),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(16),
            ),
            Text(
              "Please check your email",
              style: TextStyle(
                  fontSize: getHeight(24),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF3669C9)),
            ),
            SizedBox(
              height: getHeight(16),
            ),
            Text(
              "Confirmation code has been sent to email address ${convertLongString(string: forgotPasswordController.email.text, firstLength: 4, lastLength: 12)}",
              style: TextStyle(
                fontSize: getHeight(13),
                height: getHeight(2),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: getHeight(36)),
              width: getWidth(98),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xFFE6E6E6),
                  ),
                ),
              ),
            ),
            Text(
              "No email? Check your spam folder before you ",
              style: TextStyle(
                fontSize: getHeight(13),
                height: getHeight(2),
                color: const Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
            Countdown(
              controller: countdownController,
              seconds: 60,
              build: (BuildContext context, double time) {
                if (time > 0) {
                  return Text(
                    time.toInt().toString(),
                    style: TextStyle(
                      color: const Color(0xFF878C92),
                      fontSize: getHeight(17),
                      fontWeight: FontWeight.w500,
                    ),
                  );
                } else {
                  return Bouncing(
                    child: Text(
                      "Resend the active code",
                      style: TextStyle(
                        color: const Color(0xFF3864FF),
                        decoration: TextDecoration.underline,
                        fontSize: getHeight(14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPress: () async {
                      await forgotPasswordController.forgotPassword(context);
                      countdownController.restart();
                    },
                  );
                }
              },
              interval: Duration(seconds: 1),
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

Container confirmButtonContainer(BuildContext context) {
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
              Get.to(() => ResetPasswordScreen());
            },
            child: Text("Reset password".tr,
                style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}
