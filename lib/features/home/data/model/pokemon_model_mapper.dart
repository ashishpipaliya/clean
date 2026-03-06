import 'package:clean/features/home/data/model/pokemon_list_model.dart';
import 'package:clean/features/home/domain/entity/pokemon_entity.dart';

extension PokemonModelMapper on PokemonModel {
  PokemonEntity toEntity() {
    return PokemonEntity(
      name: name,
      url: url,
    );
  }
}
