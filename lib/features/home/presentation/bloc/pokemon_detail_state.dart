part of 'pokemon_detail_bloc.dart';

@freezed
sealed class PokemonDetailState with _$PokemonDetailState {
  const factory PokemonDetailState.initial() = _Initial;
  const factory PokemonDetailState.loading() = _Loading;
  const factory PokemonDetailState.success(PokemonDetailEntity pokemon) = _Success;
  const factory PokemonDetailState.failure(String message) = _Failure;
}
