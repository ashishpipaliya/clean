// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PokemonListModel _$PokemonListModelFromJson(Map<String, dynamic> json) =>
    _PokemonListModel(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => PokemonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonListModelToJson(_PokemonListModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

_PokemonModel _$PokemonModelFromJson(Map<String, dynamic> json) =>
    _PokemonModel(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$PokemonModelToJson(_PokemonModel instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
