import 'package:json_annotation/json_annotation.dart';

part 'Serie.g.dart';

@JsonSerializable()
class Series {
  String serieName;
  String description;
  String thumbnail;
  String cover;
  String? authorName;
  String? authorAvatar;
  int? totalEpisodes;
  int totalLikes;
  String categoryId;

  Series()
      : serieName = "",
        description = "",
        thumbnail = "",
        cover = "",
        authorName = "",
        authorAvatar = "",
        totalEpisodes = 0,
        totalLikes = 0,
        categoryId = "";

  Series.fullParam(
      this.serieName,
      this.description,
      this.thumbnail,
      this.cover,
      this.totalEpisodes,
      this.totalLikes,
      this.categoryId,
      this.authorName,
      this.authorAvatar);

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesToJson(this);

  @override
  String toString() {
    return 'serieName: $serieName, description: $description';
  }
}

@JsonSerializable()
class SeriesEpisode {
  final String name;
  final String thumbnail;
  final int price;
  final int likeInit;
  final int? comments;

  SeriesEpisode(
      this.name, this.thumbnail, this.price, this.likeInit, this.comments);

  factory SeriesEpisode.fromJson(Map<String, dynamic> json) =>
      _$SeriesEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesEpisodeToJson(this);
}
