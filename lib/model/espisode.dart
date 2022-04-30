import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Episode {
  var id;

  var name;

  var image;

  var description;

  var price;

  var likes;

  var creatorFullName;

  var creatorAvatar;

  var creatorId;

  var soldQuantity;

  Episode({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.likes,
    this.creatorFullName,
    this.creatorAvatar,
    this.creatorId,
    this.soldQuantity,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
        id: json["data"]["data"]["episodeId"],
        name: json["data"]["data"]["name"],
        description: json["data"]["data"]["description"],
        image: json["data"]["data"]["thumbnail"],
        price: json["data"]["data"]["price"],
        likes: json["data"]["data"]["likes"],
        soldQuantity: json["data"]["data"]["soldQuantity"],
        creatorFullName: json["data"]["data"]["creatorInfo"]["fullName"],
        creatorAvatar: json["data"]["data"]["creatorInfo"]["avatar"],
        creatorId: json["data"]["data"]["serie"]["creatorId"]);
  }
}
