import 'package:json_annotation/json_annotation.dart';

part 'Serie.g.dart';

@JsonSerializable()
class Series {
  String serieId;
  String serieName;
  String description;
  String thumbnail;
  String cover;
  String? authorName;
  String? authorAvatar;
  int? totalEpisodes;
  int? totalLikes;
  int? likes;
  String categoryId;
  String? category;
  int? comments;

  Series()
      : serieName = "",
        description = "",
        thumbnail = "",
        cover = "",
        authorName = "",
        authorAvatar = "",
        totalEpisodes = 0,
        totalLikes = 0,
        likes = 0,
        comments = 0,
        categoryId = "",
        category = "",
        serieId = "";

  Series.fullParam(
    this.serieName,
    this.description,
    this.thumbnail,
    this.cover,
    this.totalEpisodes,
    this.totalLikes,
    this.categoryId,
    this.category,
    this.authorName,
    this.authorAvatar,
    this.serieId,
    // this.likes,
    // this.comments,
  );

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesToJson(this);

  @override
  String toString() {
    return 'serieName: $serieName, description: $description';
  }
}

@JsonSerializable()
class SeriesEpisode {
  final String episodeId;
  final String name;
  final String thumbnail;
  final String chapter;
  final int price;
  final int likeInit;
  final int? comments;
  final bool isPublished;

  SeriesEpisode(this.name, this.thumbnail, this.price, this.likeInit,
      this.comments, this.episodeId, this.chapter, this.isPublished);

  factory SeriesEpisode.fromJson(Map<String, dynamic> json) =>
      _$SeriesEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesEpisodeToJson(this);
}
