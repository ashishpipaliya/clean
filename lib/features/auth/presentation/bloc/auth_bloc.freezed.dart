// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initialize value)?  initialize,TResult Function( _LoggedIn value)?  loggedIn,TResult Function( _LoggedOut value)?  loggedOut,TResult Function( _Login value)?  login,TResult Function( _Validate value)?  validate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _LoggedIn() when loggedIn != null:
return loggedIn(_that);case _LoggedOut() when loggedOut != null:
return loggedOut(_that);case _Login() when login != null:
return login(_that);case _Validate() when validate != null:
return validate(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initialize value)  initialize,required TResult Function( _LoggedIn value)  loggedIn,required TResult Function( _LoggedOut value)  loggedOut,required TResult Function( _Login value)  login,required TResult Function( _Validate value)  validate,}){
final _that = this;
switch (_that) {
case _Initialize():
return initialize(_that);case _LoggedIn():
return loggedIn(_that);case _LoggedOut():
return loggedOut(_that);case _Login():
return login(_that);case _Validate():
return validate(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initialize value)?  initialize,TResult? Function( _LoggedIn value)?  loggedIn,TResult? Function( _LoggedOut value)?  loggedOut,TResult? Function( _Login value)?  login,TResult? Function( _Validate value)?  validate,}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _LoggedIn() when loggedIn != null:
return loggedIn(_that);case _LoggedOut() when loggedOut != null:
return loggedOut(_that);case _Login() when login != null:
return login(_that);case _Validate() when validate != null:
return validate(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialize,TResult Function()?  loggedIn,TResult Function()?  loggedOut,TResult Function( String username,  String password)?  login,TResult Function( String? username,  String? password)?  validate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize();case _LoggedIn() when loggedIn != null:
return loggedIn();case _LoggedOut() when loggedOut != null:
return loggedOut();case _Login() when login != null:
return login(_that.username,_that.password);case _Validate() when validate != null:
return validate(_that.username,_that.password);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialize,required TResult Function()  loggedIn,required TResult Function()  loggedOut,required TResult Function( String username,  String password)  login,required TResult Function( String? username,  String? password)  validate,}) {final _that = this;
switch (_that) {
case _Initialize():
return initialize();case _LoggedIn():
return loggedIn();case _LoggedOut():
return loggedOut();case _Login():
return login(_that.username,_that.password);case _Validate():
return validate(_that.username,_that.password);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialize,TResult? Function()?  loggedIn,TResult? Function()?  loggedOut,TResult? Function( String username,  String password)?  login,TResult? Function( String? username,  String? password)?  validate,}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize();case _LoggedIn() when loggedIn != null:
return loggedIn();case _LoggedOut() when loggedOut != null:
return loggedOut();case _Login() when login != null:
return login(_that.username,_that.password);case _Validate() when validate != null:
return validate(_that.username,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class _Initialize implements AuthEvent {
  const _Initialize();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.initialize()';
}


}




/// @nodoc


class _LoggedIn implements AuthEvent {
  const _LoggedIn();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoggedIn);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.loggedIn()';
}


}




/// @nodoc


class _LoggedOut implements AuthEvent {
  const _LoggedOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoggedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.loggedOut()';
}


}




/// @nodoc


class _Login implements AuthEvent {
  const _Login({required this.username, required this.password});
  

 final  String username;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginCopyWith<_Login> get copyWith => __$LoginCopyWithImpl<_Login>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Login&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,username,password);

@override
String toString() {
  return 'AuthEvent.login(username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class _$LoginCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$LoginCopyWith(_Login value, $Res Function(_Login) _then) = __$LoginCopyWithImpl;
@useResult
$Res call({
 String username, String password
});




}
/// @nodoc
class __$LoginCopyWithImpl<$Res>
    implements _$LoginCopyWith<$Res> {
  __$LoginCopyWithImpl(this._self, this._then);

  final _Login _self;
  final $Res Function(_Login) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,}) {
  return _then(_Login(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Validate implements AuthEvent {
  const _Validate({this.username, this.password});
  

 final  String? username;
 final  String? password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidateCopyWith<_Validate> get copyWith => __$ValidateCopyWithImpl<_Validate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Validate&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,username,password);

@override
String toString() {
  return 'AuthEvent.validate(username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class _$ValidateCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$ValidateCopyWith(_Validate value, $Res Function(_Validate) _then) = __$ValidateCopyWithImpl;
@useResult
$Res call({
 String? username, String? password
});




}
/// @nodoc
class __$ValidateCopyWithImpl<$Res>
    implements _$ValidateCopyWith<$Res> {
  __$ValidateCopyWithImpl(this._self, this._then);

  final _Validate _self;
  final $Res Function(_Validate) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = freezed,Object? password = freezed,}) {
  return _then(_Validate(
username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Unknown value)?  unknown,TResult Function( _Authenticated value)?  authenticated,TResult Function( _Unauthenticated value)?  unauthenticated,TResult Function( _Loading value)?  loading,TResult Function( _LoginSuccess value)?  loginSuccess,TResult Function( _LoginFailure value)?  loginFailure,TResult Function( _FormValidate value)?  validate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Unknown() when unknown != null:
return unknown(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Loading() when loading != null:
return loading(_that);case _LoginSuccess() when loginSuccess != null:
return loginSuccess(_that);case _LoginFailure() when loginFailure != null:
return loginFailure(_that);case _FormValidate() when validate != null:
return validate(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Unknown value)  unknown,required TResult Function( _Authenticated value)  authenticated,required TResult Function( _Unauthenticated value)  unauthenticated,required TResult Function( _Loading value)  loading,required TResult Function( _LoginSuccess value)  loginSuccess,required TResult Function( _LoginFailure value)  loginFailure,required TResult Function( _FormValidate value)  validate,}){
final _that = this;
switch (_that) {
case _Unknown():
return unknown(_that);case _Authenticated():
return authenticated(_that);case _Unauthenticated():
return unauthenticated(_that);case _Loading():
return loading(_that);case _LoginSuccess():
return loginSuccess(_that);case _LoginFailure():
return loginFailure(_that);case _FormValidate():
return validate(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Unknown value)?  unknown,TResult? Function( _Authenticated value)?  authenticated,TResult? Function( _Unauthenticated value)?  unauthenticated,TResult? Function( _Loading value)?  loading,TResult? Function( _LoginSuccess value)?  loginSuccess,TResult? Function( _LoginFailure value)?  loginFailure,TResult? Function( _FormValidate value)?  validate,}){
final _that = this;
switch (_that) {
case _Unknown() when unknown != null:
return unknown(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Loading() when loading != null:
return loading(_that);case _LoginSuccess() when loginSuccess != null:
return loginSuccess(_that);case _LoginFailure() when loginFailure != null:
return loginFailure(_that);case _FormValidate() when validate != null:
return validate(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unknown,TResult Function()?  authenticated,TResult Function()?  unauthenticated,TResult Function()?  loading,TResult Function( LoginResponseEntity loginResponse)?  loginSuccess,TResult Function( String message)?  loginFailure,TResult Function( bool isFormValid)?  validate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Unknown() when unknown != null:
return unknown();case _Authenticated() when authenticated != null:
return authenticated();case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _Loading() when loading != null:
return loading();case _LoginSuccess() when loginSuccess != null:
return loginSuccess(_that.loginResponse);case _LoginFailure() when loginFailure != null:
return loginFailure(_that.message);case _FormValidate() when validate != null:
return validate(_that.isFormValid);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unknown,required TResult Function()  authenticated,required TResult Function()  unauthenticated,required TResult Function()  loading,required TResult Function( LoginResponseEntity loginResponse)  loginSuccess,required TResult Function( String message)  loginFailure,required TResult Function( bool isFormValid)  validate,}) {final _that = this;
switch (_that) {
case _Unknown():
return unknown();case _Authenticated():
return authenticated();case _Unauthenticated():
return unauthenticated();case _Loading():
return loading();case _LoginSuccess():
return loginSuccess(_that.loginResponse);case _LoginFailure():
return loginFailure(_that.message);case _FormValidate():
return validate(_that.isFormValid);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unknown,TResult? Function()?  authenticated,TResult? Function()?  unauthenticated,TResult? Function()?  loading,TResult? Function( LoginResponseEntity loginResponse)?  loginSuccess,TResult? Function( String message)?  loginFailure,TResult? Function( bool isFormValid)?  validate,}) {final _that = this;
switch (_that) {
case _Unknown() when unknown != null:
return unknown();case _Authenticated() when authenticated != null:
return authenticated();case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _Loading() when loading != null:
return loading();case _LoginSuccess() when loginSuccess != null:
return loginSuccess(_that.loginResponse);case _LoginFailure() when loginFailure != null:
return loginFailure(_that.message);case _FormValidate() when validate != null:
return validate(_that.isFormValid);case _:
  return null;

}
}

}

/// @nodoc


class _Unknown implements AuthState {
  const _Unknown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unknown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unknown()';
}


}




/// @nodoc


class _Authenticated implements AuthState {
  const _Authenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authenticated()';
}


}




/// @nodoc


class _Unauthenticated implements AuthState {
  const _Unauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class _Loading implements AuthState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class _LoginSuccess implements AuthState {
  const _LoginSuccess({required this.loginResponse});
  

 final  LoginResponseEntity loginResponse;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginSuccessCopyWith<_LoginSuccess> get copyWith => __$LoginSuccessCopyWithImpl<_LoginSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginSuccess&&(identical(other.loginResponse, loginResponse) || other.loginResponse == loginResponse));
}


@override
int get hashCode => Object.hash(runtimeType,loginResponse);

@override
String toString() {
  return 'AuthState.loginSuccess(loginResponse: $loginResponse)';
}


}

/// @nodoc
abstract mixin class _$LoginSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$LoginSuccessCopyWith(_LoginSuccess value, $Res Function(_LoginSuccess) _then) = __$LoginSuccessCopyWithImpl;
@useResult
$Res call({
 LoginResponseEntity loginResponse
});




}
/// @nodoc
class __$LoginSuccessCopyWithImpl<$Res>
    implements _$LoginSuccessCopyWith<$Res> {
  __$LoginSuccessCopyWithImpl(this._self, this._then);

  final _LoginSuccess _self;
  final $Res Function(_LoginSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loginResponse = null,}) {
  return _then(_LoginSuccess(
loginResponse: null == loginResponse ? _self.loginResponse : loginResponse // ignore: cast_nullable_to_non_nullable
as LoginResponseEntity,
  ));
}


}

/// @nodoc


class _LoginFailure implements AuthState {
  const _LoginFailure({required this.message});
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginFailureCopyWith<_LoginFailure> get copyWith => __$LoginFailureCopyWithImpl<_LoginFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.loginFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$LoginFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$LoginFailureCopyWith(_LoginFailure value, $Res Function(_LoginFailure) _then) = __$LoginFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$LoginFailureCopyWithImpl<$Res>
    implements _$LoginFailureCopyWith<$Res> {
  __$LoginFailureCopyWithImpl(this._self, this._then);

  final _LoginFailure _self;
  final $Res Function(_LoginFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_LoginFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FormValidate implements AuthState {
  const _FormValidate({required this.isFormValid});
  

 final  bool isFormValid;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormValidateCopyWith<_FormValidate> get copyWith => __$FormValidateCopyWithImpl<_FormValidate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormValidate&&(identical(other.isFormValid, isFormValid) || other.isFormValid == isFormValid));
}


@override
int get hashCode => Object.hash(runtimeType,isFormValid);

@override
String toString() {
  return 'AuthState.validate(isFormValid: $isFormValid)';
}


}

/// @nodoc
abstract mixin class _$FormValidateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$FormValidateCopyWith(_FormValidate value, $Res Function(_FormValidate) _then) = __$FormValidateCopyWithImpl;
@useResult
$Res call({
 bool isFormValid
});




}
/// @nodoc
class __$FormValidateCopyWithImpl<$Res>
    implements _$FormValidateCopyWith<$Res> {
  __$FormValidateCopyWithImpl(this._self, this._then);

  final _FormValidate _self;
  final $Res Function(_FormValidate) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isFormValid = null,}) {
  return _then(_FormValidate(
isFormValid: null == isFormValid ? _self.isFormValid : isFormValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
