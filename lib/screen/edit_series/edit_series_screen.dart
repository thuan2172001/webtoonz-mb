import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/main.dart';
import '../../controller/edit_series/edit_series_controller.dart';
import '../../controller/home_page/home_page_controller.dart';
import '../../controller/series_detail/series_detail_controller.dart';
import '../../utils/config.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/input.dart';
import '../series_detail/series_detail_screen.dart';

class EditSeriesScreen extends StatelessWidget {
  final EditSeriesController controller;

  EditSeriesScreen({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Edit series", centerTitle: true),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getWidth(25)),
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: getWidth(25),
            ),
            Text("Logo image",
                style: TextStyle(
                    fontSize: getHeight(18), fontWeight: FontWeight.bold)),
            SizedBox(
              height: getWidth(4),
            ),
            Text("This image will also the used for navigation.",
                style: TextStyle(
                  fontSize: getHeight(12),
                )),
            Text('At least 210x210 recommended.',
                style: TextStyle(
                  fontSize: getHeight(12),
                )),
            SizedBox(
              height: getWidth(9),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: getWidth(133),
                  height: getWidth(130),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Stack(children: <Widget>[
                    Obx(() {
                      if (controller.logo.value.path.isNotEmpty) {
                        return ClipRRect(
                          child: Image.file(
                            File(controller.logo.value.path),
                            width: getWidth(133),
                            height: getWidth(130),
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return ClipRRect(
                          child: Image.network(controller.thumbnail,
                            width: getWidth(133),
                            height: getWidth(130),
                            fit: BoxFit.cover,),
                        );
                      }
                    }),
                    Center(
                      child: IconButton(
                        onPressed: () {
                          pickLogo();
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/share.svg",
                          color: Colors.black,
                          width: getWidth(34),
                          height: getWidth(24.95),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: getWidth(17),
            ),
            Text("Banner",
                style: TextStyle(
                    fontSize: getHeight(18),
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: getWidth(9),
            ),
            Container(
              width: getWidth(299),
              height: getWidth(150),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Stack(children: <Widget>[
                Obx(() {
                  if (controller.banner.value.path.isNotEmpty) {
                    return ClipRRect(
                      child: Image.file(
                        File(controller.banner.value.path),
                        width: getWidth(299),
                        height: getWidth(150),
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return ClipRRect(
                      child: Image.network(controller.cover,
                          width: getWidth(299),
                          height: getWidth(150),
                          fit: BoxFit.cover),
                    );
                  }
                }),
                Center(
                  child: IconButton(
                    onPressed: () {
                      pickBanner();
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/share.svg",
                      color: Colors.black,
                      width: getWidth(34),
                      height: getWidth(24.95),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: getWidth(16),
            ),
            inputRegular(
              context,
              label: "Series name",
              hintText: "Series name",
              textEditingController: controller.seriesName,
              required: true,
            ),
            SizedBox(
              height: getWidth(16),
            ),

            Container(
              margin: EdgeInsets.only(
                left: getWidth(16),
                right: getWidth(16),
              ),
              width: double.infinity,
              child: Row(children: [
                Text("Series category",
                    style: TextStyle(
                        fontSize: getHeight(12),
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                Text("*", style: TextStyle(color: Colors.red))
              ]),
            ),
            SizedBox(height: getWidth(5),),
            DropdownButtonFormField(
              hint: Text("Categories",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: getWidth(12),
                ),),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: getWidth(10),
                  left: getWidth(18),
                  bottom: getHeight(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE6E6E6), width: getHeight(1),),
                  borderRadius: BorderRadius.circular(getHeight(6)),
                ),
              ),
              value: controller.seriesCategory,
              dropdownColor: Colors.white,
              onChanged: (String? newValue) {
                controller.seriesCategory=newValue!;
                print(controller.seriesCategory);
              },
              items: globalController.categories.value
                  .map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem<String>(
                  value: e["categoryId"],
                  child: Text(e["categoryName"],style:
                  TextStyle(color: Colors.black,fontSize: getWidth(12)),),
                );
              }).toList(),
            ),

            SizedBox(
              height: getWidth(16),
            ),
            Container(
              margin: EdgeInsets.only(
                left: getWidth(16),
                right: getWidth(16),
              ),
              width: double.infinity,
              child: Row(children: [
                Text("Description",
                    style: TextStyle(
                        fontSize: getHeight(12),
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                Text("*", style: TextStyle(color: Colors.red))
              ]),
            ),
            SizedBox(
              height: getWidth(5),
            ),
            SizedBox(
              height: getWidth(140),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                expands: true,
                maxLines: null,
                style: TextStyle(
                  fontSize: getHeight(12),
                ),
                controller: controller.description,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Description...',
                  hintStyle:
                  TextStyle(color: Colors.grey, fontSize: getHeight(12)),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(getWidth(10))),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getWidth(16),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3669C9),
                minimumSize: Size(
                  getWidth(302),
                  getWidth(47),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(getWidth(15))),
                ),
              ),
              onPressed: () async {
                controller.isLoading.value=true;
                var result=await controller.updateSeries();
                controller.isLoading.value=false;
                if(result==false){
                  Get.snackbar(
                    "Edit Series",
                    "Failed",
                    icon: Icon(Icons.sms_failed, color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    borderRadius: 20,
                    margin: EdgeInsets.all(15),
                    colorText: Colors.white,
                    duration: Duration(seconds: 2),
                    isDismissible: true,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                }
                else{
                  await Get.put(HomePageController()).getCreatorSeries();
                  await Get.put(SerieDetailController()).getSeriesInfor();
                  Get.snackbar(
                    "Edit Series",
                    "Success",
                    icon: Icon(Icons.done_outlined, color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green,
                    borderRadius: 20,
                    margin: EdgeInsets.all(15),
                    colorText: Colors.white,
                    duration: Duration(seconds: 2),
                    isDismissible: true,
                    forwardAnimationCurve: Curves.easeOutBack,

                  );
                }
              },
              child: Obx((){
                if(controller.isLoading.value==false)
                  return Text("Save");
                return  Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
            SizedBox(
              height: getWidth(16),
            ),
          ],
        ),
      ),
    );
  }

  Future pickLogo() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file == null) return;
      controller.logo.value = File(file.path);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future pickBanner() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file == null) return;
      controller.banner.value= File(file.path);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
}
