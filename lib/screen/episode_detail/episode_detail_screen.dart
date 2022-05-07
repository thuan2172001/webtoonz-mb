import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screen/episode_detail/episode_detail_component.dart';
import 'package:untitled/screen/episode_detail/read_epub_episode.dart';
import 'package:untitled/screen/episode_detail/read_pdf_episode.dart';

import '../../controller/episode_detail/episode_detail_controller.dart';
import '../../utils/config.dart';
import '../../widgets/app_bar.dart';

class EpisodeDetailScreen extends StatelessWidget {
  final EpisodeDetailController controller;
  final component = EpisodeDetailComponent();

  EpisodeDetailScreen({required this.controller});

  void _addComment() {
    TextEditingController comment = TextEditingController();
    var onTap = false.obs;
    Get.bottomSheet(
        Container(
          margin: EdgeInsets.symmetric(horizontal: getHeight(16)),
          child: Column(
            children: [
              SizedBox(
                height: getHeight(10),
              ),
              Obx(() {
                if (onTap.value == false) {
                  return Column(
                    children: [
                      Text("What do you think?",
                          style: TextStyle(
                            fontSize: getHeight(16),
                          )),
                      SizedBox(
                        height: getHeight(10),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
                        child: Center(
                          child: Text(
                              "Please share your opinion about the product",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: getHeight(16),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(10),
                      ),
                    ],
                  );
                }
                return Container();
              }),
              Expanded(
                child: TextFormField(
                  onTap: () {
                    onTap.value = true;
                  },
                  textAlignVertical: TextAlignVertical.top,
                  expands: true,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: getHeight(14),
                  ),
                  controller: comment,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Your preview',
                    hintStyle:
                        TextStyle(color: Colors.grey, fontSize: getHeight(14)),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(getWidth(10))),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(10),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black87,
                  primary: Color(0xFF3669C9),
                  minimumSize: Size(getWidth(300), getHeight(50)),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(getHeight(15))),
                  ),
                ),
                onPressed: () async {
                  Get.back();
                  await controller.addComment(comment.text);
                  controller.getComments();
                },
                child: Text('Comment',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: getHeight(14),
                    )),
              ),
              SizedBox(
                height: getHeight(10),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getWidth(18)),
          topRight: Radius.circular(getWidth(18)),
        )));
  }

  void _share() {
    Get.bottomSheet(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getHeight(30),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: getHeight(30)),
              child: Text("Share",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: getHeight(25),
                  )),
            ),
            SizedBox(
              height: getHeight(30),
            ),
            Row(
              children: [
                Expanded(
                    child: IconButton(
                  iconSize: getHeight(60),
                  icon: Icon(
                    Icons.facebook,
                    color: Color(0xFF3669C9),
                  ),
                  onPressed: () {},
                )),
                // SizedBox(
                //   width: getWidth(20),
                // ),
                Expanded(
                    child: IconButton(
                  iconSize: getHeight(60),
                  icon: Icon(
                    Icons.facebook,
                    color: Color(0xFF3669C9),
                  ),
                  onPressed: () {},
                )),
                // SizedBox(
                //   width: getWidth(20),
                // ),
                Expanded(
                    child: IconButton(
                  iconSize: getHeight(60),
                  icon: Icon(
                    Icons.facebook,
                    color: Color(0xFF3669C9),
                  ),
                  onPressed: () {},
                )),
                // SizedBox(
                //   width: getWidth(20),
                // ),
                Expanded(
                    child: IconButton(
                  iconSize: getHeight(60),
                  icon: Icon(
                    Icons.facebook,
                    color: Color(0xFF3669C9),
                  ),
                  onPressed: () {},
                )),
              ],
            ),
            SizedBox(
              height: getHeight(30),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: getHeight(30)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black87,
                  primary: Color(0xFF3669C9),
                  minimumSize: Size(getWidth(350), getHeight(50)),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(getHeight(10))),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text('Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: getWidth(16),
                    )),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getWidth(18)),
          topRight: Radius.circular(getWidth(18)),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _action(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: appBar(
          title: "Product Detail",
          centerTitle: true,
          elevation: 1.0,
          actions: [
            SizedBox(
              width: getWidth(20),
            ),
            SvgPicture.asset(
              "assets/icons/cart.svg",
              width: getWidth(24),
            ),
            SizedBox(
              width: getWidth(20),
            ),
          ]),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
        color: Colors.white,
        child: ListView(
          children: [
            _episode_info(),
            _author(),
            _description(),
            _listComment(),
          ],
        ),
      ),
    );
  }

  Column _episode_info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getWidth(16),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(getWidth(12)),
            child: Image.network(controller.episode.value.image,
                width: getWidth(350), fit: BoxFit.fill),
          ),
        ),
        SizedBox(
          height: getHeight(10),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            controller.episode.value.name,
            style: TextStyle(
              fontSize: getWidth(24),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: getHeight(4),
        ),
        Stack(
          children: [
            Positioned(
              top: getHeight(10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${controller.episode.value.price}.000 VND ",
                  style: TextStyle(
                    fontSize: getWidth(18),
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    _share();
                  },
                  iconSize: getWidth(20),
                  icon: Icon(Icons.share_sharp)),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: getWidth(18),
              color: Colors.yellow,
            ),
            Expanded(
              child: Obx(() {
                if (controller.episode.value.likes == null)
                  return Text("");
                else if (controller.episode.value.likes > 1)
                  return Text(" ${controller.episode.value.likes} Likes",
                      style: TextStyle(
                        fontSize: getWidth(15),
                      ));
                return Text(" 1 Like",
                    style: TextStyle(
                      fontSize: getWidth(15),
                    ));
              }),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(getWidth(10)),
              child: Container(
                color: Colors.greenAccent[100],
                padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
                child: Obx(
                  () => Text("Sold : ${controller.episode.value.soldQuantity}",
                      style: TextStyle(
                        fontSize: getWidth(15),
                        color: Colors.teal,
                      )),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: getWidth(10),
        ),
        Divider(color: Colors.grey[400])
      ],
    );
  }

  Column _author() {
    return Column(
      children: [
        SizedBox(
          height: getWidth(10),
        ),
        Row(
          children: [
            Obx(() => CircleAvatar(
                radius: getWidth(25),
                backgroundColor: Color(0xffFDCF09),
                child: CircleAvatar(
                    radius: getWidth(25),
                    backgroundImage:
                        NetworkImage(controller.episode.value.creatorAvatar)))),
            SizedBox(
              width: getWidth(15),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.episode.value.creatorFullName,
                    style: TextStyle(
                      fontSize: getWidth(16),
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: getHeight(5),
                ),
                Row(
                  children: [
                    Text("Author ",
                        style: TextStyle(
                          fontSize: getWidth(14),
                        )),
                    Icon(
                      Icons.gpp_good,
                      size: getWidth(22),
                      color: Color(0xFF3669C9),
                    ),
                  ],
                ),
              ],
            )),
            IconButton(
              iconSize: getWidth(20),
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            )
          ],
        ),
        SizedBox(
          height: getWidth(10),
        ),
        Divider(color: Colors.grey[400])
      ],
    );
  }

  Column _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getWidth(10),
        ),
        Text("Description Product",
            style: TextStyle(
              fontSize: getWidth(18),
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: getWidth(10),
        ),
        Text(controller.episode.value.description,
            style: TextStyle(
              fontSize: getWidth(14),
            )),
        SizedBox(
          height: getWidth(10),
        ),
        Divider(color: Colors.grey[400])
      ],
    );
  }

  Widget _action() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: getHeight(130),
      padding: EdgeInsets.only(top: getHeight(10)),
      child: Obx(() {
        if (globalController.user.value.role == "creator") {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black87,
                    primary: Colors.white,
                    minimumSize: Size(
                      getWidth(148),
                      getWidth(50),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(getWidth(15))),
                        side: BorderSide(color: Colors.black)),
                  ),
                  onPressed: () async {
                    if (controller.episode.value.isPublished == true) {
                      await controller.changeStatus("UNPUBLISH");
                      await controller.getEpisodeDetail();
                    } else {
                      await controller.changeStatus("PUBLISH");
                      await controller.getEpisodeDetail();
                    }
                  },
                  child: Obx(() {
                    if (controller.episode.value.isPublished == true) {
                      return component.publishItemText;
                    } else {
                      return component.unPublishItemText;
                    }
                  })),
              SizedBox(
                width: getWidth(16),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black87,
                  primary: Color(0xFF3669C9),
                  minimumSize: Size(getWidth(148), getWidth(50)),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(getWidth(15)))),
                ),
                onPressed: () async {
                  await controller.deleteItem();
                },
                child: component.deleteItemText,
              )
            ],
          );
        } else
          return Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(
                    getWidth(315),
                    getWidth(50),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(getWidth(15))),
                      side: BorderSide(color: Colors.black)),
                ),
                onPressed: () {
                  _addComment();
                },
                child: component.commentText,
              ),
              SizedBox(
                height: getWidth(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black87,
                        primary: Colors.white,
                        minimumSize: Size(
                          getWidth(148),
                          getWidth(50),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(getWidth(15))),
                            side: BorderSide(color: Colors.black)),
                      ),
                      onPressed: () async {
                        if (controller.episode.value.alreadyLiked == false) {
                          await controller.like();
                        } else {
                          await controller.unLike();
                        }
                        await controller.getEpisodeDetail();
                      },
                      child: Obx(() {
                        if (controller.episode.value.alreadyLiked == false)
                          return component.addToFavoriteText;
                        return component.unLikeText;
                      })),
                  SizedBox(
                    width: getWidth(16),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black87,
                      primary: Color(0xFF3669C9),
                      minimumSize: Size(getWidth(148), getWidth(50)),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(getWidth(15)))),
                    ),
                    onPressed: () async {
                      if (controller.episode.value.isBought == true) {
                        String fileType = controller.episode.value.key
                            .substring(controller.episode.value.key.length - 4);
                        if (fileType == 'epub')
                          Get.to(() => ReadEpubScreen(
                                episodeKey: controller.episode.value.key,
                                episodeTitle: controller.episode.value.name,
                              ));
                        else
                          Get.to(() => ReadPDFScreen(
                                episodeKey: controller.episode.value.key,
                                episodeTitle: controller.episode.value.name,
                              ));
                        return;
                      }
                      if (globalController.checkInCart(controller.episodeId) ==
                          true) {
                        await globalController
                            .removeFomCart(controller.episodeId);
                      } else {
                        await globalController.addToCart(controller.episodeId);
                      }
                      await globalController.getEpisodeIdsInCart();
                    },
                    child: Obx(() {
                      if (controller.episode.value.isBought == true) {
                        return component.readNowText;
                      }
                      if (globalController.checkInCart(controller.episodeId) ==
                          true) {
                        return component.removeFromCartText;
                      }
                      return component.addToCartText;
                    }),
                  )
                ],
              ),
            ],
          );
      }),
    );
  }

  Column _listComment() {
    return Column(
      children: [
        Row(children: [
          Expanded(
              child: Obx(() => Text("Review (${controller.comments.length})",
                  style: TextStyle(
                    fontSize: getWidth(18),
                    fontWeight: FontWeight.bold,
                  )))),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF3669C9),
                ),
              ),
              onPressed: () {
                controller.seeAll.value = !controller.seeAll.value;
              },
              child: Obx(() {
                if (controller.seeAll.value == false)
                  return Text('See All',
                      style: TextStyle(
                        fontSize: getWidth(16),
                      ));
                return Text('See latest',
                    style: TextStyle(
                      fontSize: getWidth(16),
                    ));
              })),
        ]),
        SizedBox(
          height: getWidth(10),
        ),
        Obx(() {
          RxList comments;
          if (controller.seeAll == false && controller.comments.length > 0) {
            comments = List.empty(growable: true).obs;
            comments.insert(0, controller.comments.value.first);
          } else
            comments = controller.comments;
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _divider(index),
                    Row(
                      children: [
                        Expanded(
                            child: Text(comments[index]["userInfo"]["fullName"],
                                style: TextStyle(
                                  fontSize: getWidth(18),
                                  fontWeight: FontWeight.bold,
                                ))),
                        Text(differenceTime(comments[index]["createdAt"]),
                            style: TextStyle(
                              fontSize: getWidth(16),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: getWidth(5),
                    ),
                    Text(comments[index]["description"],
                        style: TextStyle(
                          fontSize: getWidth(16),
                        )),
                  ],
                );
              });
        }),
        SizedBox(
          height: getWidth(150),
        ),
      ],
    );
  }

  Widget _divider(int index) {
    if (index != 0)
      return Divider(color: Colors.grey[400]);
    else
      return Container();
  }
}
