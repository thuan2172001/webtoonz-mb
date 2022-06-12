import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/series_detail/series_detail_controller.dart';
import 'package:untitled/screen/episode_detail/episode_detail_screen.dart';

import '../../controller/episode_detail/episode_detail_controller.dart';

class SearchEpisodeScreen extends StatelessWidget {
  final SerieDetailController controller = Get.put(SerieDetailController());

  SearchEpisodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration:
              new InputDecoration.collapsed(hintText: "Search episodes"),
          onChanged: (text) => controller.searchEpisodes(text),
        ),
        leading: Icon(Icons.search),
        actions: [
          IconButton(
              onPressed: () {
                controller.searchResults.clear();
                Get.back();
              },
              icon: Icon(Icons.cancel))
        ],
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.searchResults.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  var episodeId = controller.searchResults[index].episodeId;
                  var nextController=Get.put(EpisodeDetailController());
                  nextController.episodeId=episodeId;
                  await nextController.getApi();
                  Get.to(() => EpisodeDetailScreen(
                        episodeId: episodeId,
                      ));
                },
                child: ListTile(
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: double.infinity,
                      maxHeight: double.infinity,
                    ),
                    child: Image.network(
                        controller.searchResults[index].thumbnail),
                  ),
                  title: Text(controller.searchResults[index].name),
                  subtitle: Text(
                      "Chapter ${controller.searchResults[index].chapter}"),
                ),
              );
            },
          )),
    );
  }
}
