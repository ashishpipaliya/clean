import 'package:clean/features/auth/data/model/login_request.dart';
import 'package:clean/features/auth/data/model/login_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_remote_data_source.g.dart';

@injectable
@RestApi(baseUrl: 'https://dummyjson.com')
abstract class AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);
}
