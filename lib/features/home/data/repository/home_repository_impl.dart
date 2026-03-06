import 'package:clean/core/error/error_handler.dart';
import 'package:clean/core/error/failures.dart';
import 'package:clean/features/home/data/datasource/home_local_data_source.dart';
import 'package:clean/features/home/data/datasource/home_remote_data_source.dart';
import 'package:clean/features/home/data/model/pokemon_detail_model.dart';
import 'package:clean/features/home/data/model/pokemon_detail_model_mapper.dart';
import 'package:clean/features/home/data/model/pokemon_list_model.dart';
import 'package:clean/features/home/data/model/pokemon_list_model_mapper.dart';
import 'package:clean/features/home/domain/entity/pokemon_detail_entity.dart';
import 'package:clean/features/home/domain/entity/pokemon_list_entity.dart';
import 'package:clean/features/home/domain/repository/home_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;

  HomeRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, PokemonListEntity>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    final cacheKey = 'list_${limit}_$offset';
    final cached = _localDataSource.getCachedData(cacheKey);

    if (cached != null) {
      _remoteDataSource.getPokemonList(limit, offset).then((response) {
        _localDataSource.cacheData(cacheKey, response.data.toJson());
      }).catchError((_) {});

      try {
        final model = PokemonListModel.fromJson(cached);
        return Right(model.toEntity());
      } catch (e) {
        return Left(const Failure.cache('Invalid cache data'));
      }
    }

    try {
      final response = await _remoteDataSource.getPokemonList(limit, offset);
      await _localDataSource.cacheData(cacheKey, response.data.toJson());
      return Right(response.data.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handleException(e));
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, PokemonDetailEntity>> getPokemonDetail(int id) async {
    final cacheKey = 'detail_$id';
    final cached = _localDataSource.getCachedData(cacheKey);

    if (cached != null) {
      _remoteDataSource.getPokemonDetail(id, null).then((response) {
        _localDataSource.cacheData(cacheKey, response.data.toJson());
      }).catchError((_) {});

      try {
        final model = PokemonDetailModel.fromJson(cached);
        return Right(model.toEntity());
      } catch (e) {
        return Left(const Failure.cache('Invalid cache data'));
      }
    }

    try {
      final response = await _remoteDataSource.getPokemonDetail(id, null);
      await _localDataSource.cacheData(cacheKey, response.data.toJson());
      return Right(response.data.toEntity());
    } on DioException catch (e) {
      return Left(ErrorHandler.handleException(e));
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<void> clearCache() async {
    await _localDataSource.clearCache();
  }
}
