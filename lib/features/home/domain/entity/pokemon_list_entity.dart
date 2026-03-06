import 'package:clean/features/home/domain/entity/pokemon_entity.dart';

class PokemonListEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonEntity> results;

  PokemonListEntity({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });
}
