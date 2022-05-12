import 'dart:io';

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
  late CreateEpisodeController controller;
  final String seriesId;
  CreateEpisodeScreen({required this.seriesId});
  @override
  Widget build(BuildContext context) {
    controller= Get.put(CreateEpisodeController(seriesId: seriesId));
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
                            controller.logo.value,
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
                  if (controller.file.value.path.isNotEmpty) {
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
                          Text(controller.fileName.value),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
                Center(
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
                  ),
                ),
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
              onPressed: () async {
                controller.isLoading.value=true;
                var result=await controller.createEpisode();
                controller.isLoading.value=false;
                if(result==null){
                  Get.snackbar(
                    "Create Episode",
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
                  controller.reset();
                  Get.snackbar(
                    "Create Episode",
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
      if(file==null)return;
      controller.logo.value=File(file.path);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      final file=result.files.first;
      if(file==null||file.path==null)return;
      controller.file.value = File(file.path!);
      controller.fileName.value=file.name;
      if (controller.fileName.value.length > 30) {
        controller.fileName.value = "..." +
            controller.fileName.value.substring(
                controller.fileName.value.length - 27, controller.fileName.value.length);
      }
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
    }
  }
}
