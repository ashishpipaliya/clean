import 'package:clean/core/error/failures.dart';
import 'package:clean/features/home/domain/entity/pokemon_detail_entity.dart';
import 'package:clean/features/home/domain/repository/home_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeDetailUsecase {
  final HomeRepository _repository;

  GetHomeDetailUsecase(this._repository);

  Future<Either<Failure, PokemonDetailEntity>> call(int id) {
    return _repository.getPokemonDetail(id);
  }
}
