import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/episode_detail/episode_detail_controller.dart';
import '../../controller/signup/signup_controller.dart';
import '../../utils/config.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/layout.dart';
import '../login/login_screen.dart';
import '../signup/signup_creator_screen.dart';
import '../signup/signup_customer_screen.dart';

class EpisodeDetailScreen extends GetView<EpisodeDetailController> {
  final String episodeId;

  EpisodeDetailScreen({required this.episodeId});

  late EpisodeDetailController episodeDetailController;

  void _addComment() {
    Get.bottomSheet(
        Container(
          margin: EdgeInsets.symmetric(horizontal: getHeight(16)),
          child: Column(
            children: [
              Text("What do you think?"),
              Text("Please share your opinion about the product"),
              SizedBox(
                height: getHeight(10),
              ),
              Expanded(
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  expands: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Your preview',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(10),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(20),
                    backgroundColor: const Color(0xFF3669C9),
                    side: const BorderSide(
                      color: Color(0xFFE6E6E6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: getHeight(20))),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Comment",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        )));
  }

  void _share() {
    Get.bottomSheet(
        Container(
          margin: EdgeInsets.symmetric(horizontal: getHeight(16)),
          child: Column(
            children: [
              Text("Share"),
              Row(
                children: [
                  Expanded(
                      child: IconButton(
                    iconSize: 72,
                    icon: Icon(Icons.facebook),
                    onPressed: () {},
                  )),
                  Expanded(
                      child: IconButton(
                    iconSize: 72,
                    icon: Icon(Icons.facebook),
                    onPressed: () {},
                  )),
                  Expanded(
                      child: IconButton(
                    iconSize: 72,
                    icon: Icon(Icons.facebook),
                    onPressed: () {},
                  )),
                  Expanded(
                      child: IconButton(
                    iconSize: 72,
                    icon: Icon(Icons.facebook),
                    onPressed: () {},
                  )),
                ],
              ),
              SizedBox(
                height: getHeight(10),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(20),
                    backgroundColor: const Color(0xFF3669C9),
                    side: const BorderSide(
                      color: Color(0xFFE6E6E6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: getHeight(20))),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        )));
  }

  void _addToCart() {
    var quantity = 0.obs;
    Get.bottomSheet(
        Container(
          margin: EdgeInsets.symmetric(horizontal: getHeight(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(child: const Text("Add to Cart")),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close))
              ]),
              Divider(color: Colors.grey[400]),
              Row(
                children: [
                  Expanded(child: Text("Quantity")),
                  IconButton(
                      onPressed: () {
                        if (quantity > 0) quantity--;
                      },
                      icon: Icon(Icons.remove)),
                  Obx(() => Text("$quantity")),
                  IconButton(
                      onPressed: () {
                        quantity++;
                      },
                      icon: Icon(Icons.add))
                ],
              ),
              Divider(color: Colors.grey[400]),
              Text("Total Price"),
              Obx(() => Text(
                  "VND ${quantity * episodeDetailController.episode.value.price}.000")),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(20),
                    backgroundColor: const Color(0xFF3669C9),
                    side: const BorderSide(
                      color: Color(0xFFE6E6E6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: getHeight(20))),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
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
        Obx(
          () => Image.network(episodeDetailController.episode.value.image),
        ),
        SizedBox(
          height: getHeight(24),
        ),
        Row(
          children: [
            Expanded(
              child: Obx(
                  () => Text(episodeDetailController.episode.value.name ?? "")),
            ),
            IconButton(
                onPressed: () {
                  _share();
                },
                icon: Icon(Icons.share))
          ],
        ),
        Obx(() {
          // if (episodeDetailController.episode.value.price > 0)
          return Text("VND ${episodeDetailController.episode.value.price}.000");
          // return Text("0 VND");
        }),
        Row(
          children: [
            Icon(Icons.star),
            Expanded(
              child: Obx(() {
                if (episodeDetailController.episode.value.price == null)
                  return Text("");
                else if (episodeDetailController.episode.value.price > 1)
                  return Text(
                      "${episodeDetailController.episode.value.price} Likes");
                return Text("1 Like");
              }),
            ),
            Obx(
              () => Text(
                  "Sold:${episodeDetailController.episode.value.soldQuantity}"),
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
        Row(
          children: [
            Obx(() => CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xffFDCF09),
                child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        episodeDetailController.episode.value.creatorAvatar)))),
            SizedBox(
              width: getWidth(15),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                    episodeDetailController.episode.value.creatorFullName)),
                SizedBox(
                  height: getHeight(5),
                ),
                Row(
                  children: [
                    Text("Author"),
                    Icon(Icons.gpp_good),
                  ],
                ),
              ],
            )),
            IconButton(
              iconSize: 20,
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            )
          ],
        ),
        SizedBox(
          height: getHeight(24),
        ),
        Divider(color: Colors.grey[400])
      ],
    );
  }

  Column _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description Product"),
        Obx(
          () => Text(
              "${episodeDetailController.episode.value.description ?? ""}"),
        ),
        Divider(color: Colors.grey[400])
      ],
    );
  }

  Column _action() {
    return Column(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              minimumSize: Size.fromHeight(20),
              backgroundColor: const Color(0xFF3669C9),
              side: const BorderSide(
                color: Color(0xFFE6E6E6),
              ),
              padding: EdgeInsets.symmetric(vertical: getHeight(16))),
          onPressed: () {
            _addComment();
          },
          child: const Text(
            "Comment",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: getHeight(24),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFF3669C9),
                    side: const BorderSide(
                      color: Color(0xFFE6E6E6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: getHeight(16))),
                onPressed: () async {},
                child: const Text(
                  "Add to Favorite",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: getWidth(10),
            ),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFF3669C9),
                    side: const BorderSide(
                      color: Color(0xFFE6E6E6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: getHeight(16))),
                onPressed: () {
                  _addToCart();
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: getHeight(10),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFF3669C9),
                    side: const BorderSide(
                      color: Color(0xFFE6E6E6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: getHeight(16))),
                onPressed: () {},
                child: const Text(
                  "Unlike item",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: getWidth(10),
            ),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFF3669C9),
                    side: const BorderSide(
                      color: Color(0xFFE6E6E6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: getHeight(16))),
                onPressed: () {},
                child: const Text(
                  "Enjoy now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _listComment() {
    return Column(
      children: [
        Row(children: [
          Expanded(child: Text("Review()")),
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
                  return Text('See All');
                return Text('See latest');
              })),
        ]),
        SizedBox(
          height: getHeight(24),
        ),
        Container(
            height: getHeight(140),
            child: Obx(() {
              if (episodeDetailController.seeAll.value == false &&
                  episodeDetailController.comments.value.length > 0) {
                var e = episodeDetailController.comments.value[0];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(e["userInfo"]["fullName"])),
                        Text(differenceTime(e["createdAt"])),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(5),
                    ),
                    Text(e["description"]),
                    SizedBox(
                      height: getHeight(10),
                    ),
                  ],
                );
              }

              return ListView(
                children: episodeDetailController.comments.value.map((e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(e["userInfo"]["fullName"])),
                          Text(differenceTime(e["createdAt"])),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(5),
                      ),
                      Text(e["description"]),
                      SizedBox(
                        height: getHeight(10),
                      ),
                    ],
                  );
                }).toList(),
              );
            }))
      ],
    );
  }
}
