import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/episode_detail/episode_detail_controller.dart';
import '../../utils/config.dart';
import '../../widgets/app_bar.dart';

class EpisodeDetailScreen extends GetView<EpisodeDetailController> {
  final String episodeId;

  EpisodeDetailScreen({required this.episodeId});

  late EpisodeDetailController episodeDetailController;

  void _addComment() {
    TextEditingController comment = TextEditingController();
    Get.bottomSheet(
        Container(
          margin: EdgeInsets.symmetric(horizontal: getHeight(16)),
          child: Column(
            children: [
              SizedBox(
                height: getHeight(10),
              ),
              Text("What do you think?",
                  style: TextStyle(
                    fontSize: getWidth(20),
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
                        fontSize: getWidth(20),
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
                    fontSize: getWidth(20),
                  ),
                  controller: comment,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Your preview',
                    hintStyle:
                        TextStyle(color: Colors.grey, fontSize: getWidth(16)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                  primary: Colors.blue,
                  minimumSize: Size(getWidth(350), getHeight(60)),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(getWidth(15))),
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
                      fontSize: getWidth(18),
                    )),
              ),
              SizedBox(
                height: getHeight(20),
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: getHeight(36)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getHeight(30),
              ),
              Text("Share",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getWidth(30),
                  )),
              SizedBox(
                height: getHeight(30),
              ),
              Row(
                children: [
                  Expanded(
                      child: IconButton(
                    iconSize: getWidth(70),
                    icon: Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    onPressed: () {

                    },
                  )),
                  Expanded(
                      child: IconButton(
                    iconSize: getWidth(70),
                    icon: Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
                  )),
                  Expanded(
                      child: IconButton(
                    iconSize: getWidth(70),
                    icon: Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
                  )),
                  Expanded(
                      child: IconButton(
                    iconSize: getWidth(70),
                    icon: Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
                  )),
                ],
              ),
              SizedBox(
                height: getHeight(30),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black87,
                  primary: Colors.blue,
                  minimumSize: Size(getWidth(350), getHeight(60)),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(getWidth(15))),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text('Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: getWidth(18),
                    )),
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

  void _addToCart() {
    var quantity = 1.obs;
    Get.bottomSheet(
        Container(
          margin: EdgeInsets.symmetric(horizontal: getHeight(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                    child: Text("Add to Cart",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getWidth(20),
                        ))),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close, size: getWidth(30)))
              ]),
              Divider(color: Colors.grey[400]),
              Row(
                children: [
                  Expanded(
                      child: Text("Quantity",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getWidth(18),
                          ))),
                  IconButton(
                      onPressed: () {
                        if (quantity > 0) quantity--;
                      },
                      icon: Icon(
                        Icons.remove,
                        size: getWidth(30),
                      )),
                  Obx(() => Text("$quantity",
                      style: TextStyle(
                        fontSize: getWidth(18),
                      ))),
                  IconButton(
                      onPressed: () {
                        quantity++;
                      },
                      icon: Icon(
                        Icons.add,
                        size: getWidth(30),
                      ))
                ],
              ),
              Divider(color: Colors.grey[400]),
              SizedBox(
                height: getHeight(10),
              ),
              Text("Total Price",
                  style: TextStyle(
                    fontSize: getWidth(16),
                  )),
              SizedBox(
                height: getHeight(5),
              ),
              Obx(() => Text(
                  "VND ${quantity * episodeDetailController.episode.value.price}.000",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getWidth(18),
                  ))),
              SizedBox(
                height: getHeight(30),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black87,
                  primary: Colors.blue,
                  minimumSize: Size(getWidth(350), getHeight(60)),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(getWidth(15))),
                  ),
                ),
                onPressed: () {
                  episodeDetailController.addToCart(quantity.value);
                  Get.back();
                },
                child: Text('Add to card',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: getWidth(18),
                    )),
              ),
              SizedBox(
                height: getHeight(20),
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

  @override
  Widget build(BuildContext context) {
    episodeDetailController =
        Get.put(EpisodeDetailController(episodeId: this.episodeId));

    return controller.obx(
      (state) {
        return Scaffold(
          appBar: appBar(
              title: "Product Detail",
              hideBackButton: true,
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
            margin: EdgeInsets.symmetric(horizontal: getHeight(16)),
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
          height: getHeight(24),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(getWidth(12)),
            child: Image.network(episodeDetailController.episode.value.image,
                width: getWidth(350), fit: BoxFit.fill),
          ),
        ),
        SizedBox(
          height: getHeight(24),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                episodeDetailController.episode.value.name,
                style: TextStyle(
                  fontSize: getWidth(26),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: getWidth(5),
            ),
            IconButton(
                onPressed: () {
                  _share();
                },
                icon: Icon(Icons.share_sharp, size: getWidth(30)))
          ],
        ),
        SizedBox(
          height: getHeight(10),
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
          height: getHeight(10),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: getHeight(16),
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
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.greenAccent[100],
                padding: EdgeInsets.symmetric(
                    vertical: getHeight(3), horizontal: getWidth(10)),
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
          height: getHeight(16),
        ),
        Divider(color: Colors.grey[400])
      ],
    );
  }

  Column _author() {
    return Column(
      children: [
        SizedBox(
          height: getHeight(10),
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
                      color: Colors.blue,
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
          height: getHeight(10),
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
          height: getHeight(10),
        ),
        Text("Description Product",
            style: TextStyle(
              fontSize: getWidth(20),
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: getHeight(5),
        ),
        Text(episodeDetailController.episode.value.description,
            style: TextStyle(
              fontSize: getWidth(18),
            )),
        SizedBox(
          height: getHeight(10),
        ),
        Divider(color: Colors.grey[400])
      ],
    );
  }

  Column _action() {
    return Column(
      children: [
        SizedBox(
          height: getHeight(10),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black87,
            primary: Colors.white,
            minimumSize: Size(getWidth(350), getHeight(60)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(getWidth(15))),
                side: BorderSide(color: Colors.black)),
          ),
          onPressed: () {
            _addComment();
          },
          child: Text('Comment',
              style: TextStyle(
                fontSize: getWidth(18),
              )),
        ),
        SizedBox(
          height: getHeight(24),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black87,
                  primary: Colors.white,
                  minimumSize: Size(getWidth(160), getHeight(60)),
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
                    return Text(
                      "Add to Favorite",
                      style: TextStyle(
                        fontSize: getWidth(16),
                      ),
                    );
                  return Text(
                    "Unlike",
                    style: TextStyle(
                      fontSize: getWidth(16),
                    ),
                  );
                })),
            SizedBox(
              width: getWidth(25),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black87,
                  primary: Colors.blue,
                  minimumSize: Size(getWidth(160), getHeight(60)),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(getWidth(15)))),
                ),
                onPressed: () {
                  if (episodeDetailController.episode.value.isBought == false)
                    _addToCart();
                },
                child: Obx(() {
                  if (episodeDetailController.episode.value.isBought == false)
                    return Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: getWidth(16),
                      ),
                    );
                  else
                    return Text(
                      "Enjoy now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: getWidth(16),
                      ),
                    );
                })),
          ],
        ),
        SizedBox(
          height: getHeight(20),
        ),
      ],
    );
  }

  Column _listComment() {
    return Column(
      children: [
        SizedBox(
          height: getHeight(10),
        ),
        Row(children: [
          Expanded(
              child: Obx(() =>
                  Text("Review(${episodeDetailController.comments.length})",
                      style: TextStyle(
                        fontSize: getWidth(20),
                        fontWeight: FontWeight.bold,
                      )))),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
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
          height: getHeight(10),
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
              height: getHeight(getHeight(300)),
              child: Obx(() {
                return ListView(
                  shrinkWrap: true,  physics: ClampingScrollPhysics(),
                  children: comments.value.map((e) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getWidth(10))),
                      color: Colors.grey[200],
                      child: Container(
                        padding: EdgeInsets.all(getWidth(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(e["userInfo"]["fullName"],
                                        style: TextStyle(
                                          fontSize: getWidth(18),
                                          fontWeight: FontWeight.bold,
                                        ))),
                                Text(differenceTime(e["createdAt"]),
                                    style: TextStyle(
                                      fontSize: getWidth(16),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: getHeight(5),
                            ),
                            Text(e["description"],
                                style: TextStyle(
                                  fontSize: getWidth(16),
                                )),
                            SizedBox(
                              height: getHeight(10),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }));
        }),
        SizedBox(
          height: getHeight(10),
        ),
      ],
    );
  }
}
