import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_list_model.freezed.dart';
part 'pokemon_list_model.g.dart';

@freezed
abstract class PokemonListModel with _$PokemonListModel {
  const factory PokemonListModel({
    required int count,
    String? next,
    String? previous,
    required List<PokemonModel> results,
  }) = _PokemonListModel;

  factory PokemonListModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonListModelFromJson(json);
}


@freezed
abstract class PokemonModel with _$PokemonModel {
  const factory PokemonModel({
    required String name,
    required String url,
  }) = _PokemonModel;

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);
}
