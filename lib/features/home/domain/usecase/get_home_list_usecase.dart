import 'package:clean/core/error/failures.dart';
import 'package:clean/features/home/domain/entity/pokemon_list_entity.dart';
import 'package:clean/features/home/domain/repository/home_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeListUsecase {
  final HomeRepository _repository;

  GetHomeListUsecase(this._repository);

  Future<Either<Failure, PokemonListEntity>> call({
    required int limit,
    required int offset,
  }) {
    return _repository.getPokemonList(limit: limit, offset: offset);
  }

  Future<void> clearCache() {
    return _repository.clearCache();
  }
}
