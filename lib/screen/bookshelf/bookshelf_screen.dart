import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/bookshelf/bookshelf_controller.dart';
import 'package:untitled/controller/episode_detail/episode_detail_controller.dart';
import 'package:untitled/screen/episode_detail/episode_detail_screen.dart';
import 'package:untitled/screen/favorite/search_component.dart';
import 'package:untitled/screen/series_detail/episode_card.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';

class BookshelfScreen extends StatelessWidget {
  late BookshelfController controller;

  static const Color defaultColor = Color(0xFF3669C9);

  @override
  Widget build(BuildContext context) {
    controller = Get.put(BookshelfController());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
          title: "Bookshelf",
          centerTitle: true,
          elevation: 1.0,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search, color: Colors.black),
              onPressed: () {
                Get.to(() => SearchEpisode(episodes: controller.bookshelf.value.listEpisode));
              },
            )
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child: ListView(
                children: <Widget>[
                  Obx(() => GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.bookshelf.value.listEpisode.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () async {
                            var episodeDetailController = EpisodeDetailController(episodeId: controller.bookshelf.value.listEpisode[index].episodeId);
                            await episodeDetailController.getApi();
                            Get.to(() => EpisodeDetailScreen(controller: episodeDetailController));
                          },
                          child: EpisodeCard(episode:controller.bookshelf.value.listEpisode[index])
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 20,
                        childAspectRatio: 4 / 5.7),
                  ),)
                ],
              )
          ),
        )
    );
  }
}