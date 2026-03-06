import 'package:clean/features/home/data/model/pokemon_detail_model.dart';
import 'package:clean/features/home/domain/entity/pokemon_detail_entity.dart';

extension PokemonDetailModelMapper on PokemonDetailModel {
  PokemonDetailEntity toEntity() {
    return PokemonDetailEntity(
      id: id ?? 0,
      name: name ?? '',
      height: height ?? 0,
      weight: weight ?? 0,
      types: types
              ?.where((t) => t.type?.name != null)
              .map((t) => t.type!.name!)
              .toList() ??
          [],
      abilities: abilities
              ?.where((a) => a.ability?.name != null)
              .map((a) => a.ability!.name!)
              .toList() ??
          [],
      imageUrl: sprites?.other?.officialArtwork?.frontDefault ??
          sprites?.frontDefault ??
          '',
    );
  }
}
