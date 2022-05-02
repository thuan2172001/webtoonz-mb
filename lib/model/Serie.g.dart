// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Serie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Series _$SeriesFromJson(Map<String, dynamic> json) => Series()
  ..serieId = json['serieId'] as String
  ..serieName = json['serieName'] as String
  ..description = json['description'] as String
  ..thumbnail = json['thumbnail'] as String
  ..cover = json['cover'] as String
  ..authorName = json['authorName'] as String?
  ..authorAvatar = json['authorAvatar'] as String?
  ..totalEpisodes = json['totalEpisodes'] as int?
  ..totalLikes = json['totalLikes'] as int?
  ..likes = json['likes'] as int?
  ..categoryId = json['categoryId'] as String
  ..category = json['category'] as String?
  ..comments = json['comments'] as int?;

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'serieId': instance.serieId,
      'serieName': instance.serieName,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'cover': instance.cover,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'totalEpisodes': instance.totalEpisodes,
      'totalLikes': instance.totalLikes,
      'likes': instance.likes,
      'categoryId': instance.categoryId,
      'category': instance.category,
      'comments': instance.comments,
    };

SeriesEpisode _$SeriesEpisodeFromJson(Map<String, dynamic> json) =>
    SeriesEpisode(
      json['name'] as String,
      json['thumbnail'] as String,
      json['price'] as int,
      json['likeInit'] as int,
      json['comments'] as int?,
      json['episodeId'] as String,
      json['chapter'] as String,
    );

Map<String, dynamic> _$SeriesEpisodeToJson(SeriesEpisode instance) =>
    <String, dynamic>{
      'episodeId': instance.episodeId,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'chapter': instance.chapter,
      'price': instance.price,
      'likeInit': instance.likeInit,
      'comments': instance.comments,
    };
