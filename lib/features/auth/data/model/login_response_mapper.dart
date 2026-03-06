// Generated mapper extension for LoginResponse
import 'package:clean/features/auth/data/model/login_response.dart';
import 'package:clean/features/auth/domain/entity/login_response_entity.dart';

extension LoginResponseMapper on LoginResponse {
  LoginResponseEntity toEntity() => LoginResponseEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
    );
}

extension LoginResponseEntityMapper on LoginResponseEntity {
  LoginResponse toModel() => LoginResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
    );
}
