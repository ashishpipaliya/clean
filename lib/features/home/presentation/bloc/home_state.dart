part of 'home_bloc.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({
    required List<PokemonEntity> pokemonList,
    required bool hasMore,
    required int currentOffset,
  }) = _Loaded;
  const factory HomeState.loadingMore({
    required List<PokemonEntity> pokemonList,
    required int currentOffset,
  }) = _LoadingMore;
  const factory HomeState.error(String message) = _Error;
}
