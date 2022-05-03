import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddPaymentSuccessScreen extends StatelessWidget {
  const AddPaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        width: 60.w,
        height: 20.h,
        child: FittedBox(
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
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
