import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/bookshelf/bookshelf_controller.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/controller/payment/payment_controller.dart';
import 'package:untitled/screen/account/user_account.dart';
import 'package:untitled/screen/bookshelf/bookshelf_screen.dart';
import 'package:untitled/screen/change_password/change_password_screen.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/payment/payment_method.dart';
import 'package:untitled/screen/transaction/transaction_screen.dart';
import 'package:untitled/utils/config.dart';

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.put(GlobalController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getHeight(12),
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getWidth(24),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(12),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(16),
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(10),
                      ),
                      Row(
                        children: [
                          Container(
                            width: getWidth(48),
                            height: getWidth(48),
                            child: SvgPicture.asset(
                              "assets/icons/account.svg",
                              width: getWidth(48),
                              height: getWidth(48),
                            ),
                          ),
                          SizedBox(
                            width: getWidth(8),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              globalController.user.value.fullName.toString(),
                              style: TextStyle(
                                  fontSize: getWidth(16),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(
                          left: getWidth(16),
                          right: getWidth(16),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Get.to(UserAccountScreen());
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: getWidth(32),
                                              height: getWidth(32),
                                              child: SvgPicture.asset(
                                                "assets/icons/menu-ic-1.svg",
                                                height: getWidth(32),
                                              ),
                                            ),
                                            SizedBox(
                                              width: getWidth(8),
                                            ),
                                            Text(
                                              'Update information',
                                              style: TextStyle(
                                                  fontSize: getWidth(16)),
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: getWidth(15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: const Color(0xFFE6E6E6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                // add
                                // var card = CardDetails.fromJson({
                                //   "number": "4242424242424242",
                                //   "expirationYear": 42,
                                //   "expirationMonth": 6,
                                //   "cvc": "424"
                                // });
                                // var paymentMethod =
                                //     await StripeService.createSetupIntent(card);
                                // StripeService.createNewPayment(
                                //     paymentMethod, context);

                                // delete
                                // await StripeService.deletePayment(
                                //     "pm_1Kv1thCkuVKGrqVo4JMUPyAb", context);
                                Get.put(PaymentController()).isPickCard.value = false;
                                Get.to(() => PaymentMethodScreen());
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: getWidth(32),
                                              height: getWidth(32),
                                              child: SvgPicture.asset(
                                                "assets/icons/menu-ic-2.svg",
                                                height: getWidth(32),
                                              ),
                                            ),
                                            SizedBox(
                                              width: getWidth(8),
                                            ),
                                            Text(
                                              'Payment management',
                                              style: TextStyle(
                                                  fontSize: getWidth(16)),
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: getWidth(15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: const Color(0xFFE6E6E6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Get.to(TransactionScreen());
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: getWidth(32),
                                              height: getWidth(32),
                                              child: SvgPicture.asset(
                                                "assets/icons/menu-ic-3.svg",
                                                height: getWidth(32),
                                              ),
                                            ),
                                            SizedBox(
                                              width: getWidth(8),
                                            ),
                                            Text(
                                              'Transaction',
                                              style: TextStyle(
                                                  fontSize: getWidth(16)),
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: getWidth(15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: const Color(0xFFE6E6E6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Get.put(BookshelfController()).getBookshelf();
                                Get.to(BookshelfScreen());
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: getWidth(32),
                                              height: getWidth(32),
                                              child: SvgPicture.asset(
                                                "assets/icons/menu-ic-4.svg",
                                                height: getWidth(32),
                                              ),
                                            ),
                                            SizedBox(
                                              width: getWidth(8),
                                            ),
                                            Text(
                                              "Bookshelf",
                                              style: TextStyle(
                                                  fontSize: getWidth(16)),
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(ChangePasswordScreen());
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: getWidth(32),
                                              height: getWidth(32),
                                              child: SvgPicture.asset(
                                                "assets/icons/menu-ic-5.svg",
                                                height: getWidth(32),
                                              ),
                                            ),
                                            SizedBox(
                                              width: getWidth(8),
                                            ),
                                            Text(
                                              "Change Password",
                                              style: TextStyle(
                                                  fontSize: getWidth(16)),
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight(16),
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: getHeight(16),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: getWidth(32),
                                            height: getWidth(32),
                                            child: SvgPicture.asset(
                                              "assets/icons/menu-ic-6.svg",
                                              height: getWidth(32),
                                            ),
                                          ),
                                          SizedBox(
                                            width: getWidth(8),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              GlobalController().dispose();
                                              GlobalController().onChangeTab(0);
                                              Get.offAll(() => LoginScreen());
                                            },
                                            child: Container(
                                              width: getWidth(200),
                                              child: Text(
                                                "Log out",
                                                style: TextStyle(
                                                    fontSize: getWidth(16)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getHeight(16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
