import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/screen/cart_screen/cart_screen.dart';
import 'package:untitled/screen/home_page/home_page_tab_screen.dart';
import 'package:untitled/screen/favorite/favorite_screen.dart';
import 'package:untitled/widgets/bottom_navigator.dart';
import 'package:untitled/widgets/sidebar-menu.dart';

class HomePageScreen extends StatelessWidget {
  GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: bottomNavigator(),
        body: PageView(
          controller: globalController.pageController,
          children: [
            HomePageTabScreen(),
            FavoriteScreen(),
            CartScreen(),
            SideBarMenu()
          ],
        ),
      ),
    );
  }
}
