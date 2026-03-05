# Flutter Project Rules

## Flexibility Notice
This document provides recommended patterns and structures. Be flexible and adapt to the existing project architecture. Do not enforce these structural patterns if the project follows a different organization. Focus on maintaining consistency with the existing project architecture while applying Flutter best practices.

## Dependencies
- Always use the latest compatible versions of dependencies
- Check pub.dev for the most recent stable versions before adding packages
- Run `flutter pub outdated` to identify outdated dependencies
- Prefer null-safe packages and ensure compatibility with current Flutter SDK

## Required Packages & Patterns
- **freezed**: Use for immutable models and BLoC events/states (instead of equatable)
- **injectable**: Use for dependency injection (instead of GetIt manually)
- **retrofit**: Use with dio for API class generation
- **fpdart**: Use for functional programming (Either type for error handling)
- **hive_ce**: Use for local database storage
- **dio**: HTTP client for API calls (with retrofit)
- **flutter_bloc**: State management with BLoC pattern
- **flutter_secure_storage**: Store secrets like jwt token, or session tokens
- **envied**: Store compile time secrets

## Code Modifications
- Do not modify more than 5 files at a time without explicit permission
- Ask for user confirmation before making large-scale changes
- Break down large refactoring tasks into smaller, manageable chunks

## Documentation
- Do not create new markdown files unnecessarily
- For important changes, update the root README.md with a changelog or notes section
- Keep documentation minimal and focused on essential information

## Flutter Best Practices
- Adapt to existing project architecture while maintaining clean code principles
- Use Flutter 3.x features and Material 3 design
- Implement clean architecture with BLoC pattern
- Follow proper state management principles
- Use injectable for dependency injection with @injectable, @singleton, @lazySingleton annotations
- Implement proper error handling with Either type from fpdart
- Use unified error types across the entire project
- Follow platform-specific design guidelines
- Use proper localization techniques
- Follow the official Flutter style guide and Dart conventions
- Use const constructors wherever possible for performance

## Recommended Project Structure
```
lib/
  core/
    constants/
    theme/
    utils/
    widgets/
  features/
    feature_name/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        bloc/
        pages/
        widgets/
  l10n/
  main.dart
test/
  unit/
  widget/
  integration/
```

## Coding Guidelines
1. Use proper null safety practices
2. Implement proper error handling with Either<Failure, Success> from fpdart
3. Use unified error types (create a base Failure class) across the project
4. Follow proper naming conventions
5. Use proper widget composition
6. Implement proper routing using GoRouter
7. Use proper form validation
8. Follow proper state management with BLoC
9. Use injectable for dependency injection with proper annotations
10. Use proper asset management
11. Follow proper testing practices
12. Use freezed for all models, BLoC events, and BLoC states
13. Use retrofit with dio for API calls
14. Use hive_ce for local database operations

## Widget Guidelines
1. Keep widgets small and focused on a single responsibility
2. Use const constructors when possible
3. Implement proper widget keys for performance and testing
4. Follow proper layout principles
5. Use proper widget lifecycle methods
6. Implement proper error boundaries
7. Use proper performance optimization techniques
8. Follow proper accessibility guidelines

## Performance Guidelines
1. Use proper image caching
2. Implement proper list view optimization (ListView.builder for long lists)
3. Use proper build methods optimization
4. Follow proper state management patterns
5. Implement proper memory management
6. Use proper platform channels when needed
7. Follow proper compilation optimization techniques
8. Avoid unnecessary rebuilds by using const widgets
9. Implement lazy loading for data-heavy screens
10. Profile performance using Flutter DevTools when needed

## Testing Guidelines
1. Write tests only when explicitly requested
2. Write unit tests for business logic
3. Implement widget tests for UI components
4. Use integration tests for feature testing
5. Implement proper mocking strategies
6. Use proper test coverage tools
7. Follow proper test naming conventions
8. Implement proper CI/CD testing
9. Follow the test pyramid: more unit tests, fewer widget/integration tests

## State Management
- Use BLoC pattern as the primary state management solution
- Implement proper separation between business logic and UI
- Use proper event-driven architecture
- Handle loading, success, and error states properly
- Use freezed for BLoC events and states (with @freezed annotation)
- Define sealed classes for events and states using freezed unions

## Data Layer Patterns
- Use freezed for all data models with @freezed annotation
- Use retrofit for API service classes with @RestApi annotation
- Use dio as the HTTP client with retrofit
- Return Either<Failure, T> from repositories using fpdart
- Use hive_ce for local storage with TypeAdapters
- Create unified Failure types (NetworkFailure, CacheFailure, ServerFailure, etc.)

## Dependency Injection
- Use injectable package for DI setup
- Annotate classes with @injectable, @singleton, @lazySingleton
- Use @module for third-party dependencies (Dio, Hive, etc.)
- Generate injection code with injectable_generator
- Initialize DI in main.dart with configureDependencies()

## Error Handling
- Use Either<Failure, T> from fpdart for all repository methods
- Create a base Failure class and extend it for specific error types
- Use fold() method to handle Either results in BLoC
- Map exceptions to appropriate Failure types in data sources
- Maintain consistent error handling patterns across the project

## Platform-Specific Code
- Keep platform-specific code in respective folders (android/, ios/)
- Use platform channels only when necessary
- Test on both platforms when making platform-specific changes
- Follow platform-specific design guidelines (Material for Android, Cupertino for iOS)
