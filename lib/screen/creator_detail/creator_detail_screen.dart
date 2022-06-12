import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:untitled/controller/chat/chat_controller.dart';
import 'package:untitled/controller/creator_detail/creator_detail_controller.dart';
import 'package:untitled/i18n.dart';
import 'package:untitled/screen/chat/chat_page.dart';
import 'package:untitled/screen/favorite/search_component.dart';
import 'package:untitled/screen/home_page/home_page_component.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';

class CreatorDetailScreen extends StatefulWidget {
  final String creatorId;
  CreatorDetailScreen({Key? key, required this.creatorId}) : super(key: key);

  @override
  State<CreatorDetailScreen> createState() => _CreatorDetailScreenState();

  static const TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: Color(0xFF545454),
    fontSize: 25,
  );
  static const TextStyle _style2 = TextStyle(
    color: Colors.black87,
    fontSize: 18,
  );
}

class _CreatorDetailScreenState extends State<CreatorDetailScreen> {
  final CreatorDetailController controller = Get.put(CreatorDetailController());
  @override
  Widget build(BuildContext context) {
    controller.getCreatorInfo(widget.creatorId);
    controller.getList(widget.creatorId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          title: "Creator Detail",
          centerTitle: true,
          elevation: 1.0,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search, color: Colors.black),
              onPressed: () {
                Get.to(() => SearchSeries(series: controller.listSeries));
              },
            )
          ]),
      body: Obx(
          () => controller.creatorInfo.value.id != null ? body() : Container()),
    );
  }

  FutureBuilder body() {
    return FutureBuilder(
        future: controller.init(widget.creatorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                color: Colors.white,
                child: Obx(() => ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        controller.creatorInfo.value.id != null
                            ? _creatorInfo()
                            : Container(),
                        _listSeries(),
                      ],
                    )));
          } else if (snapshot.hasError)
            return Column(
              children: [
                Text(
                  snapshot.error.toString(),
                ),
              ],
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Column _creatorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getWidth(20),
        ),
        Row(
          children: [
            CircleAvatar(
              radius: getWidth(45),
              backgroundColor: Colors.grey[200],
              child: CircleAvatar(
                  radius: getWidth(44),
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: getWidth(38),
                      backgroundImage:
                          NetworkImage(controller.creatorInfo.value.avatar))),
            ),
            SizedBox(
              width: getWidth(15),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.creatorInfo.value.fullName,
                    style: TextStyle(
                      fontSize: getWidth(20),
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: getHeight(10),
                ),
                OutlinedButton(
                  onPressed: () async {
                    var id =
                        await controller.getConversationId(widget.creatorId);
                    if (id != null) {
                      ChatController chatController = Get.put(ChatController());
                      chatController.conversationId.value = id;
                      chatController.receiverId.value = widget.creatorId;
                      chatController.stopFetchConversations();
                      Get.to(() => MessagesPage());
                    }
                  },
                  child: Text(
                    "Message",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(120, 45),
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
              ],
            )),
          ],
        ),
        SizedBox(
          height: getWidth(20),
        ),
        Text("Description",
            style: TextStyle(
              fontSize: getWidth(18),
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: getWidth(10),
        ),
        Text(controller.creatorInfo.value.description,
            style: TextStyle(
              fontSize: getWidth(14),
            )),
        SizedBox(
          height: getWidth(15),
        ),
        Container(
          child: Divider(),
          height: 1,
          color: Colors.grey[200],
        ),
        SizedBox(
          height: getWidth(8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "${controller.creatorInfo.value.seriesQuantity}",
                  style: CreatorDetailScreen._style1,
                ),
                Text(
                  "Series",
                  style: CreatorDetailScreen._style2,
                ),
              ],
            ),
            Container(color: Colors.grey[200], width: 1, height: 60),
            Column(
              children: [
                Text(
                  "${controller.creatorInfo.value.episodeQuantity}",
                  style: CreatorDetailScreen._style1,
                ),
                Text(
                  "Episodes",
                  style: CreatorDetailScreen._style2,
                ),
              ],
            ),
            Container(color: Colors.grey[200], width: 1, height: 60),
            Column(
              children: [
                Text(
                  "${dateFormat(controller.creatorInfo.value.createdAt)}",
                  style: CreatorDetailScreen._style1,
                ),
                Text(
                  "Joined",
                  style: CreatorDetailScreen._style2,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Column _listSeries() {
    var ratio = controller.listSeries.length / controller.limit;
    var numberOfPages =
        ratio > ratio.floor() ? ratio.floor() + 1 : ratio.floor();
    numberOfPages = max(numberOfPages, 1);

    return Column(
      children: [
        GridView.builder(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.pageSeries.length,
          itemBuilder: (BuildContext context, int index) {
            return SeriesItem(seriesInfo: controller.pageSeries[index]);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 20,
              childAspectRatio: 4 / 5.5),
        ),
        NumberPaginator(
          numberPages: numberOfPages,
          initialPage: 0,
          onPageChange: (index) {
            controller.getSeries(index + 1, widget.creatorId);
          },
          buttonShape: CircleBorder(
              side: BorderSide(width: 1, color: Colors.transparent)),
          buttonSelectedForegroundColor: Colors.white,
          buttonSelectedBackgroundColor: Colors.blue,
          buttonUnselectedForegroundColor: Colors.black,
          buttonUnselectedBackgroundColor: Colors.white,
        ),
        SizedBox(height: getWidth(5))
      ],
    );
  }

  String dateFormat(String date) {
    DateTime today = DateTime.now();
    DateTime createdAt = DateTime.parse(date);
    int dif = today.difference(createdAt).inDays;
    if (dif >= 365) return "${dif ~/ 365} years";
    if (dif >= 30) return "${dif ~/ 30} months";
    return "1 month";
  }
}
