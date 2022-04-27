import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/utils/config.dart';

import 'bounce_button.dart';

Container bottomNavigator() {
  GlobalController globalController = Get.put(GlobalController());
  return Container(
    height: getHeight(80),
    width: double.infinity,
    color: Colors.white,
    child: Stack(
      children: [
        Container(
          height: 1,
          color: Color(0xFFE5E5E5),
        ),
        Align(
          alignment: Alignment.center,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        globalController.onChangeTab(0);
                      },
                      child: Container(
                        color: Colors.white,
                        width: getWidth(60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/home.svg",
                              width: getWidth(24),
                              color: globalController.currentPage.value == 0
                                  ? Color(0xFF3669C9)
                                  : Color(0xFF999999),
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                  fontSize: getWidth(12),
                                  color: globalController.currentPage.value == 0
                                      ? Color(0xFF3669C9)
                                      : Color(0xFF999999)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        globalController.onChangeTab(1);
                      },
                      child: Container(
                        color: Colors.white,
                        width: getWidth(60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/ic_menu_wishlist.svg",
                              width: getWidth(24),
                              color: globalController.currentPage.value == 1
                                  ? Color(0xFF3669C9)
                                  : Color(0xFF999999),
                            ),
                            Text(
                              "Favorite",
                              style: TextStyle(
                                  fontSize: getWidth(12),
                                  color: globalController.currentPage.value == 1
                                      ? Color(0xFF3669C9)
                                      : Color(0xFF999999)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        globalController.onChangeTab(2);
                      },
                      child: Container(
                        color: Colors.white,
                        width: getWidth(60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/ic_menu_order.svg",
                              width: getWidth(24),
                              color: globalController.currentPage.value == 2
                                  ? Color(0xFF3669C9)
                                  : Color(0xFF999999),
                            ),
                            Text(
                              "Order",
                              style: TextStyle(
                                  fontSize: getWidth(12),
                                  color: globalController.currentPage.value == 2
                                      ? Color(0xFF3669C9)
                                      : Color(0xFF999999)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        globalController.onChangeTab(3);
                      },
                      child: Container(
                        width: getWidth(65),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/user.svg",
                              width: getWidth(24),
                              color: globalController.currentPage.value == 3
                                  ? Color(0xFF3669C9)
                                  : Color(0xFF999999),
                            ),
                            FittedBox(
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: getWidth(12),
                                    color:
                                        globalController.currentPage.value == 3
                                            ? Color(0xFF3669C9)
                                            : Color(0xFF999999)),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
