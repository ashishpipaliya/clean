// Example: How to use NetworkErrorHandler in your repositories
// This file is for reference only - delete it when you understand the pattern

import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';
import '../network/dio_client.dart';

// Example repository implementation
class ExampleRepository {
  // Example API call with proper error handling
  Future<Either<Failure, Map<String, dynamic>>> fetchData() async {
    try {
      // Make your API call here
      // final response = await dio.get('/endpoint');
      // return Right(response.data);
      
      throw UnimplementedError('Replace with actual API call');
    } catch (e) {
      // Use NetworkErrorHandler to convert any error to Failure
      return Left(NetworkErrorHandler.handleError(e));
    }
  }

  // Example with custom error handling
  Future<Either<Failure, String>> postData(Map<String, dynamic> data) async {
    try {
      // Make your API call
      // final response = await dio.post('/endpoint', data: data);
      
      // Validate response if needed
      // if (response.data == null) {
      //   return const Left(Failure.server('Invalid response'));
      // }
      
      // return Right(response.data['id']);
      
      throw UnimplementedError('Replace with actual API call');
    } catch (e) {
      return Left(NetworkErrorHandler.handleError(e));
    }
  }
}

// Example BLoC usage
class ExampleBloc {
  void handleResult(Either<Failure, dynamic> result) {
    result.fold(
      // Handle error
      (failure) {
        failure.when(
          server: (message) {
            // Show server error to user
            print('Server Error: $message');
          },
          network: (message) {
            // Show network error to user
            print('Network Error: $message');
          },
          cache: (message) {
            // Handle cache error
            print('Cache Error: $message');
          },
          validation: (message) {
            // Show validation error
            print('Validation Error: $message');
          },
          unauthorized: (message) {
            // Navigate to login or show auth error
            print('Auth Error: $message');
          },
          unknown: (message) {
            // Show generic error
            print('Unknown Error: $message');
          },
        );
      },
      // Handle success
      (data) {
        print('Success: $data');
      },
    );
  }
}
