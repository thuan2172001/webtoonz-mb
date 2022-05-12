import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/screen/home_page/home_page_screen.dart';

class AddPaymentSuccessScreen extends StatelessWidget {
  const AddPaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonHeight =
        MediaQuery.of(context).orientation == Orientation.portrait ? 20 : 10;
    double buttonWidth =
        MediaQuery.of(context).orientation == Orientation.portrait ? 60 : 30;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/success.png"),
            ),
            Text(
              "Success!",
              style: TextStyle(fontSize: 20.sp),
            ),
            Text(
              "Thank you for choosing our app",
              style: TextStyle(fontSize: 10.sp),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        width: buttonWidth.w,
        height: buttonHeight.h,
        child: FittedBox(
          child: FloatingActionButton.extended(
            onPressed: () {
              Get.offAll(() => HomePageScreen());
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            label: Text("Continue shopping"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
