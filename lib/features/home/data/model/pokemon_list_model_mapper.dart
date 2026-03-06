import 'package:clean/features/home/data/model/pokemon_list_model.dart';
import 'package:clean/features/home/data/model/pokemon_model_mapper.dart';
import 'package:clean/features/home/domain/entity/pokemon_list_entity.dart';

extension PokemonListModelMapper on PokemonListModel {
  PokemonListEntity toEntity() {
    return PokemonListEntity(
      count: count,
      next: next,
      previous: previous,
      results: results.map((model) => model.toEntity()).toList(),
    );
  }
}
