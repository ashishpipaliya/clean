# Error Handling Guide

## Overview
This project uses a unified error handling approach with `fpdart`'s `Either` type and `freezed` for type-safe error handling.

## Structure

### 1. Exceptions (Data Layer)
Located in `exceptions.dart` - thrown in data sources:
- `ServerException` - API/server errors
- `NetworkException` - Network connectivity issues
- `CacheException` - Local storage errors
- `UnauthorizedException` - Authentication/authorization errors

### 2. Failures (Domain/Presentation Layer)
Located in `failures.dart` - used with `Either<Failure, T>`:
- `Failure.server()` - Server-side errors
- `Failure.network()` - Network connectivity issues
- `Failure.cache()` - Local storage errors
- `Failure.validation()` - Input validation errors
- `Failure.unauthorized()` - Auth errors
- `Failure.unknown()` - Unexpected errors

### 3. NetworkErrorHandler
Located in `dio_client.dart` - converts Dio errors to Failures:
- Handles all DioException types
- Maps HTTP status codes to appropriate Failures
- Extracts error messages from API responses

## Usage Pattern

### In Repositories
```dart
Future<Either<Failure, User>> getUser(String id) async {
  try {
    final response = await dio.get('/users/$id');
    return Right(User.fromJson(response.data));
  } catch (e) {
    return Left(NetworkErrorHandler.handleError(e));
  }
}
```

### In BLoC
```dart
final result = await repository.getUser(userId);
result.fold(
  (failure) => emit(state.copyWith(
    status: Status.error,
    error: failure,
  )),
  (user) => emit(state.copyWith(
    status: Status.success,
    user: user,
  )),
);
```

### In UI
```dart
state.error?.when(
  server: (msg) => AppSnackbar.show(context, msg, type: SnackbarType.error),
  network: (msg) => AppSnackbar.show(context, msg, type: SnackbarType.warning),
  unauthorized: (msg) {
    AppSnackbar.show(context, msg, type: SnackbarType.error);
    context.go('/login');
  },
  // ... handle other cases
);
```

## Network Error Coverage

The `NetworkErrorHandler` handles:
- ✅ Connection timeouts
- ✅ No internet connection
- ✅ HTTP status codes (400, 401, 403, 404, 500, etc.)
- ✅ Request cancellation
- ✅ SSL/Certificate errors
- ✅ Socket exceptions
- ✅ Custom error message extraction from API responses

## Best Practices

1. Always use `Either<Failure, T>` in repository return types
2. Use `NetworkErrorHandler.handleError()` to convert exceptions
3. Handle all failure cases in BLoC using `.when()` or `.fold()`
4. Show user-friendly messages in UI
5. Log errors for debugging (already handled by Dio interceptor)
