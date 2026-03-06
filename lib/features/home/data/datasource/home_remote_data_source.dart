import 'package:clean/features/home/data/model/pokemon_detail_model.dart';
import 'package:clean/features/home/data/model/pokemon_list_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_remote_data_source.g.dart';

@injectable
@RestApi(baseUrl: 'https://pokeapi.co/api/v2/')
abstract class HomeRemoteDataSource {
  @factoryMethod
  factory HomeRemoteDataSource(Dio dio) = _HomeRemoteDataSource;

  @GET('/pokemon')
  Future<HttpResponse<PokemonListModel>> getPokemonList(
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @GET('/pokemon/{id}')
  Future<HttpResponse<PokemonDetailModel>> getPokemonDetail(
    @Path('id') int id,
    @Header('If-None-Match') String? etag,
  );
}
