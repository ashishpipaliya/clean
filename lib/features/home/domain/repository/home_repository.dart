import 'package:clean/core/error/failures.dart';
import 'package:clean/features/home/domain/entity/pokemon_detail_entity.dart';
import 'package:clean/features/home/domain/entity/pokemon_list_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class HomeRepository {
  Future<Either<Failure, PokemonListEntity>> getPokemonList({
    required int limit,
    required int offset,
  });

  Future<Either<Failure, PokemonDetailEntity>> getPokemonDetail(int id);

  Future<void> clearCache();
}
