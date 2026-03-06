part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadPokemonList() = _LoadPokemonList;
  const factory HomeEvent.loadMorePokemon() = _LoadMorePokemon;
  const factory HomeEvent.refreshPokemonList() = _RefreshPokemonList;
}
