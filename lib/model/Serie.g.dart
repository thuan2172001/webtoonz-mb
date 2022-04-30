// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Serie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Series _$SeriesFromJson(Map<String, dynamic> json) => Series(
      json['serieName'] as String,
      json['description'] as String,
      json['thumbnail'] as String,
      json['cover'] as String,
      json['totalEpisodes'] as int,
      json['likes'] as int,
      json['category'] as String,
      (json['episodes'] as List<dynamic>)
          .map((e) => SeriesEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['authorName'] as String,
      json['authorAvatar'] as String,
    );

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'serieName': instance.serieName,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'cover': instance.cover,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'totalEpisodes': instance.totalEpisodes,
      'likes': instance.likes,
      'category': instance.category,
      'episodes': instance.episodes,
    };

SeriesEpisode _$SeriesEpisodeFromJson(Map<String, dynamic> json) =>
    SeriesEpisode(
      json['name'] as String,
      json['chapter'] as String,
      json['thumbnail'] as String,
      json['price'] as int,
      json['likeInit'] as int,
    );

Map<String, dynamic> _$SeriesEpisodeToJson(SeriesEpisode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chapter': instance.chapter,
      'thumbnail': instance.thumbnail,
      'price': instance.price,
      'likeInit': instance.likeInit,
    };
