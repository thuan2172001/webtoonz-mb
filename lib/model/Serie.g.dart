// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Serie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Series _$SeriesFromJson(Map<String, dynamic> json) => Series()
  ..serieName = json['serieName'] as String
  ..description = json['description'] as String
  ..thumbnail = json['thumbnail'] as String
  ..cover = json['cover'] as String
  ..authorName = json['authorName'] as String?
  ..authorAvatar = json['authorAvatar'] as String?
  ..totalEpisodes = json['totalEpisodes'] as int?
  ..totalLikes = json['totalLikes'] as int
  ..categoryId = json['categoryId'] as String;

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'serieName': instance.serieName,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'cover': instance.cover,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'totalEpisodes': instance.totalEpisodes,
      'totalLikes': instance.totalLikes,
      'categoryId': instance.categoryId,
    };

SeriesEpisode _$SeriesEpisodeFromJson(Map<String, dynamic> json) =>
    SeriesEpisode(
      json['name'] as String,
      json['thumbnail'] as String,
      json['price'] as int,
      json['likeInit'] as int,
      json['comments'] as int?,
    );

Map<String, dynamic> _$SeriesEpisodeToJson(SeriesEpisode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'price': instance.price,
      'likeInit': instance.likeInit,
      'comments': instance.comments,
    };
