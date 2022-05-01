import 'package:json_annotation/json_annotation.dart';

part 'Serie.g.dart';

@JsonSerializable()
class Series {
  final String serieName;
  final String description;
  final String thumbnail;
  final String cover;
  final String authorName;
  final String authorAvatar;
  final int totalEpisodes;
  final int price;
  final int likes;
  final String category;
  final List<SeriesEpisode> episodes;

  Series(
      this.serieName,
      this.description,
      this.thumbnail,
      this.cover,
      this.totalEpisodes,
      this.likes,
      this.price,
      this.category,
      this.episodes,
      this.authorName,
      this.authorAvatar);

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesToJson(this);
}

@JsonSerializable()
class SeriesEpisode {
  final String name;
  final String chapter;
  final String thumbnail;
  final int price;
  final int likeInit;
  final int comments = 83;

  SeriesEpisode(
      this.name, this.chapter, this.thumbnail, this.price, this.likeInit);

  factory SeriesEpisode.fromJson(Map<String, dynamic> json) =>
      _$SeriesEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesEpisodeToJson(this);
}
