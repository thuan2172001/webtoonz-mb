import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/utils/config.dart';

class ResetSuccessScreen extends StatelessWidget {
  const ResetSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            left: getWidth(24),
            right: getWidth(24),
            top: getHeight(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/success.png"),
              ),
              SizedBox(
                height: getHeight(10),
              ),
              Text(
                "Success!",
                style: TextStyle(fontSize: getHeight(18)),
              ),
              Text(
                "Reset password success !",
                style: TextStyle(fontSize: getHeight(18)),
              ),
              SizedBox(
                height: getHeight(20),
              ),
              Container(
                height: getHeight(48),
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF3669C9),
                    side: BorderSide(color: Colors.white),
                  ),
                  onPressed: () async {
                    Get.offAll((LoginScreen()));
                  },
                  child: Text(
                    "Login",
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
      ),
    );
  }
}
