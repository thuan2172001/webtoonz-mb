import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/cart/cart_controller.dart';
import 'package:untitled/model/espisode.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/image.dart';

import '../../main.dart';

class OrderItem extends StatelessWidget {
  final Episode episode;
  const OrderItem({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(104),
      margin: EdgeInsets.only(
        top: getHeight(25),
        left: getWidth(21),
        right: getWidth(21),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 80,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: getImage(
                      episode.image,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        episode.name ?? "",
                        style: TextStyle(
                          fontSize: getWidth(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: GestureDetector(
              onTap: () async {
                Get.put(CartController()).episodeIds.removeWhere((element) => element == episode.id);
                await Get.put(CartController()).updateCart();
                await globalController.getEpisodeIdsInCart();
              },
              child: Container(
                height: getHeight(50),
                child: Container(
                  // width: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                margin: EdgeInsets.only(
                  left: getWidth(20),
                  top: getWidth(12),
                  bottom: getWidth(12),
                ),
                padding: EdgeInsets.only(
                  top: getHeight(24),
                  bottom: getHeight(24),
                  left: getHeight(11),
                  right: getHeight(11),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
