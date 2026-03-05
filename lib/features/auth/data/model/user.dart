import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
@freezed
abstract class User with _$User {
  factory User({
     int? id,
     String? username,
     String? email,
     String? firstName,
     String? lastName,
     String? gender,
     String? image,
     String? accessToken,
     String? refreshToken,
  }) = _User;
}
