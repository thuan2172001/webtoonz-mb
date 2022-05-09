import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/controller/create_episode/create_episode_controller.dart';
import '../../utils/config.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/input.dart';

class CreateEpisodeScreen extends StatelessWidget {
  RxString _logoPath = "".obs;
  RxString _filePath = "".obs;
  RxString _fileName = "".obs;

  @override
  Widget build(BuildContext context) {
    CreateEpisodeController controller = Get.put(CreateEpisodeController());
    return Scaffold(
      appBar: appBar(title: "Create episode", centerTitle: true),
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
            Text("File",
                style: TextStyle(
                    fontSize: getHeight(18),
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: getWidth(3),
            ),
            Text("Only PDF,UPUB format are allowed",
                style: TextStyle(
                  fontSize: getHeight(12),
                )),
            Text("File must be less than 100MB",
                style: TextStyle(
                  fontSize: getHeight(12),
                )),
            SizedBox(
              height: getWidth(9),
            ),
            Container(
              width: getWidth(299),
              height: getWidth(150),
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Stack(children: <Widget>[
                Container(
                  width: getWidth(299),
                  height: getWidth(150),
                  color: Color(0xFFF8F9FA),
                ),
                Obx(() {
                  if (_filePath.value.isNotEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: getWidth(8),
                          ),
                          Container(
                              width: getWidth(154),
                              height: getWidth(100),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/icons/file_icon.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: null),
                          SizedBox(
                            height: getWidth(8),
                          ),
                          Text(_fileName.value),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
                Positioned(
                    top: getWidth(50),
                    left: getWidth(124.55),
                    child: IconButton(
                      onPressed: () {
                        pickFile();
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
            SizedBox(
              height: getWidth(16),
            ),
            inputRegular(
              context,
              label: "Episode name",
              hintText: "Episode name",
              textEditingController: controller.episodeName,
              required: true,
            ),
            SizedBox(
              height: getWidth(16),
            ),
            inputRegular(
              context,
              label: "Price (VND)",
              hintText: "0.00",
              textEditingController: controller.price,
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

  Future pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      this._filePath.value = result.files.first.path!;
      this._fileName.value = result.files.first.name;
      if (this._fileName.value.length > 30) {
        this._fileName.value = "..." +
            this._fileName.value.substring(
                this._fileName.value.length - 27, this._fileName.value.length);
      }
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
    }
  }
}
