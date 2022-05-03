import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/account_management/account_controller.dart';
import 'package:untitled/main.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/input.dart';

class UserAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountController accountController = Get.put(AccountController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
        title: "Account information",
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: getWidth(27),
          right: getWidth(27),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(10),
            ),
            Container(
              child: Image.asset(
                "assets/icons/user-default.png",
                width: getWidth(72),
              ),
            ),
            SizedBox(
              height: getHeight(8),
            ),
            Text(
              globalController.user.value.mail.toString(),
              style: TextStyle(
                color: Color(0xFFABABAB),
              ),
            ),
            SizedBox(
              height: getHeight(16),
            ),
            Obx(() => inputRegular(
                  context,
                  textEditingController: accountController.fullName,
                  label: "Full Name",
                  hintText: "Full Name",
                  enabled: accountController.isEditting.value,
                )),
            SizedBox(
              height: getHeight(10),
            ),
            Obx(() => inputRegular(
                  context,
                  textEditingController: accountController.phoneNumber,
                  label: "Phone number",
                  hintText: "Phone number",
                  enabled: accountController.isEditting.value,
                )),
            SizedBox(
              height: getHeight(10),
            ),
            Obx(() => inputRegular(
                  context,
                  textEditingController: accountController.age,
                  label: "Age",
                  hintText: "Age",
                  enabled: accountController.isEditting.value,
                )),
            SizedBox(
              height: getHeight(20),
            ),
            Obx(
              () => Container(
                height: getHeight(52),
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: accountController.isEditting.value
                        ? Color(0xFF3669C9)
                        : Colors.white,
                    side: BorderSide(
                      color: accountController.isEditting.value
                          ? Colors.white
                          : Color(0xFF3669C9),
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    if (accountController.isEditting.value) {
                      accountController.editProfile(context);
                    } else {
                      accountController.isEditting.value = true;
                    }
                  },
                  child: Text(
                    accountController.isEditting.value ? "Save" : "Edit",
                    style: TextStyle(
                      color: accountController.isEditting.value
                          ? Colors.white
                          : Color(0xFF3669C9),
                      fontWeight: FontWeight.bold,
                    ),
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
