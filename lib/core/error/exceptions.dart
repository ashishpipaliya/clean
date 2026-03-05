// Custom exceptions for data layer
// These are thrown in data sources and converted to Failures in repositories

class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Server error occurred']);
}

class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'Network error occurred']);
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache error occurred']);
}

class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException([this.message = 'Unauthorized access']);
}
