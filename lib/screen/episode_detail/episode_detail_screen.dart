import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screen/episode_detail/episode_detail_component.dart';

import '../../controller/episode_detail/episode_detail_controller.dart';
import '../../utils/config.dart';
import '../../widgets/app_bar.dart';

class EpisodeDetailScreen extends GetView<EpisodeDetailController> {
  final String episodeId;
  final component=EpisodeDetailComponent();
  EpisodeDetailScreen({required this.episodeId});

  late EpisodeDetailController episodeDetailController;

  void _addComment() {
    TextEditingController comment = TextEditingController();
    Get.bottomSheet(
        Container(
          height: getHeight(600),
          margin: EdgeInsets.symmetric(horizontal: getHeight(16)),
          child: Column(
            children: [
              SizedBox(
                height: getHeight(10),
              ),
              Text("What do you think?",
                  style: TextStyle(
                    fontSize: getHeight(20),
                  )),
              SizedBox(
                height: getHeight(15),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
                child: Center(
                  child: Text("Please share your opinion about the product",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getHeight(20),
                      )),
                ),
              ),
              SizedBox(
                height: getHeight(10),
              ),
              Expanded(
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  expands: true,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: getHeight(20),
                  ),
                  controller: comment,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Your preview',
                    hintStyle:
                        TextStyle(color: Colors.grey, fontSize: getHeight(20)),
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
                  minimumSize: Size(getWidth(300), getHeight(60)),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(getHeight(15))),
                  ),
                ),
                onPressed: () async {
                  Get.back();
                  await episodeDetailController.addComment(comment.text);
                  episodeDetailController.getComments();
                },
                child: Text('Comment',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: getHeight(16),
                    )),
              ),
              SizedBox(
                height: getHeight(15),
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
                    fontSize: getHeight(30),
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
                  minimumSize: Size(getWidth(350), getHeight(60)),
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
    episodeDetailController =
        Get.put(EpisodeDetailController(episodeId: this.episodeId));
    return controller.obx(
      (state) {
        return Scaffold(
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
                _action(),
              ],
            ),
          ),
        );
      },
      onLoading: CircularProgressIndicator(),
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
            child: Image.network(episodeDetailController.episode.value.image,
                width: getWidth(350), fit: BoxFit.fill),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: getWidth(5)),
          child: IconButton(
              onPressed: () {
                _share();
              },
              iconSize: getWidth(35),
              icon: Icon(Icons.share_sharp)),
        ),
        Text(
          episodeDetailController.episode.value.name,
          style: TextStyle(
            fontSize: getWidth(26),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: getWidth(10),
        ),
        Text(
          "VND ${episodeDetailController.episode.value.price}.000",
          style: TextStyle(
            fontSize: getWidth(20),
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: getWidth(10),
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
                if (episodeDetailController.episode.value.likes == null)
                  return Text("");
                else if (episodeDetailController.episode.value.likes > 1)
                  return Text(
                      " ${episodeDetailController.episode.value.likes} Likes",
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
                  () => Text(
                      "Sold : ${episodeDetailController.episode.value.soldQuantity}",
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
                    backgroundImage: NetworkImage(
                        episodeDetailController.episode.value.creatorAvatar)))),
            SizedBox(
              width: getWidth(15),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(episodeDetailController.episode.value.creatorFullName,
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
              fontSize: getWidth(20),
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: getWidth(10),
        ),
        Text(episodeDetailController.episode.value.description,
            style: TextStyle(
              fontSize: getWidth(18),
            )),
        SizedBox(
          height: getWidth(10),
        ),
        Divider(color: Colors.grey[400])
      ],
    );
  }

  Column _action() {
    return Column(
      children: [
        SizedBox(
          height: getWidth(10),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            minimumSize: Size(
              getWidth(305),
              getWidth(50),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(getWidth(15))),
                side: BorderSide(color: Colors.black)),
          ),
          onPressed: () {
            _addComment();
          },
          child: component.commentText,
        ),
        SizedBox(
          height: getWidth(24),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black87,
                  primary: Colors.white,
                  minimumSize: Size(
                    getWidth(142.5),
                    getWidth(50),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(getWidth(15))),
                      side: BorderSide(color: Colors.black)),
                ),
                onPressed: () {
                  if (episodeDetailController.episode.value.alreadyLiked ==
                      false) {
                    episodeDetailController.like();
                    episodeDetailController.episode.value.alreadyLiked = true;
                    episodeDetailController.episode.value.likes++;
                  } else {
                    episodeDetailController.unLike();
                    episodeDetailController.episode.value.alreadyLiked = false;
                    episodeDetailController.episode.value.likes--;
                  }
                  episodeDetailController.episode.refresh();
                },
                child: Obx(() {
                  if (episodeDetailController.episode.value.alreadyLiked ==
                      false)
                    return component.addToFavoriteText;
                  return component.unLikeText;
                })),
            SizedBox(
              width: getWidth(23),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.black87,
                primary: Color(0xFF3669C9),
                minimumSize: Size(getWidth(142.5), getWidth(50)),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(getWidth(15)))),
              ),
              onPressed: () {
                if (episodeDetailController.episode.value.isBought == true) {
                  return;
                }
                if (episodeDetailController.inCart.value==true) {
                  episodeDetailController.inCart.value=false;
                  globalController.removeFomCart(episodeId);
                }
                else {
                  episodeDetailController.inCart.value = true;
                  globalController.addToCart(episodeId);
                }
                episodeDetailController.inCart.refresh();

              },
              child: Obx(() {
                if (episodeDetailController.episode.value.isBought == true) {
                  return component.readNowText;
                }
                if (episodeDetailController.inCart.value==true) {
                  return component.removeFromCartText;
                }
                return component.addToCartText;
              }),
            )
          ],
        ),
        SizedBox(height: getWidth(20)),
      ],
    );
  }

  Column _listComment() {
    return Column(
      children: [
        Row(children: [
          Expanded(
              child: Obx(() =>
                  Text("Review (${episodeDetailController.comments.length})",
                      style: TextStyle(
                        fontSize: getWidth(20),
                        fontWeight: FontWeight.bold,
                      )))),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF3669C9),
                ),
              ),
              onPressed: () {
                episodeDetailController.seeAll.value =
                    !episodeDetailController.seeAll.value;
              },
              child: Obx(() {
                if (episodeDetailController.seeAll.value == false)
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
          if (episodeDetailController.seeAll == false &&
              episodeDetailController.comments.length > 0) {
            comments = List.empty(growable: true).obs;
            comments.insert(0, episodeDetailController.comments.value.first);
          } else
            comments = episodeDetailController.comments;
          return Container(
            height: getHeight(getWidth(300)),
            child: ListView(
                children: comments.value
                    .asMap()
                    .map((index, value) => MapEntry(
                        index,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _divider(index),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(value["userInfo"]["fullName"],
                                        style: TextStyle(
                                          fontSize: getWidth(18),
                                          fontWeight: FontWeight.bold,
                                        ))),
                                Text(differenceTime(value["createdAt"]),
                                    style: TextStyle(
                                      fontSize: getWidth(16),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: getWidth(5),
                            ),
                            Text(value["description"],
                                style: TextStyle(
                                  fontSize: getWidth(16),
                                )),
                          ],
                        )))
                    .values
                    .toList()),
          );
        }),
        SizedBox(
          height: getHeight(5),
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
