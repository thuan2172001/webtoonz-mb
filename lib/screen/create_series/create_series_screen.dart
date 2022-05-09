import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/create_series/create_series_controller.dart';
import '../../utils/config.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/input.dart';

class CreateSeriesScreen extends StatelessWidget {
  RxString _logoPath = "".obs;
  RxString _bannerPath = "".obs;

  @override
  Widget build(BuildContext context) {
    CreateSeriesController controller = Get.put(CreateSeriesController ());
    return Scaffold(
      appBar: appBar(title: "Create series", centerTitle: true),
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
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Stack(children: <Widget>[
                    Obx(() {
                      if (_logoPath.value.isNotEmpty) {
                        return ClipRRect(
                          child: Image.file(
                            File(_logoPath.value),
                            width: getWidth(133),
                            height: getWidth(130),
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return Container(
                          width: getWidth(133),
                          height: getWidth(130),
                          color: Color(0xFFF8F9FA),
                        );
                      }
                    }),
                    Positioned(
                        top: getWidth(45),
                        left: getWidth(43.5),
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
                        )),
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
                  if (_bannerPath.value.isNotEmpty) {
                    return ClipRRect(
                      child: Image.file(
                        File(_bannerPath.value),
                        width: getWidth(299),
                        height: getWidth(150),
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return Container(
                      width: getWidth(299),
                      height: getWidth(150),
                      color: Color(0xFFF8F9FA),
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
            inputRegular(
              context,
              label: "Series category",
              hintText: "Categories",
              textEditingController: controller.seriesCategory,
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
              onPressed: () {},
              child: Text("Save"),
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
      this._logoPath.value = file.path;
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future pickBanner() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file == null) return;
      this._bannerPath.value = file.path;
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
}
