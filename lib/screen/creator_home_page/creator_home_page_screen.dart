import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/screen/creator_home_page/creator_home_page_tab_screen.dart';
import 'package:untitled/widgets/bottom_navigator.dart';
import 'package:untitled/widgets/sidebar-menu.dart';

class CreatorHomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: bottomNavigator(),
        body: PageView(
          controller: Get.put(GlobalController()).pageController,
          children: [
            CreatorHomePageTabScreen(),
            Container(),
            Container(),
            SideBarMenu()
          ],
        ),
      ),
    );
  }
}
