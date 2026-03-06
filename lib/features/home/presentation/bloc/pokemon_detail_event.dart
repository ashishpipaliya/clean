part of 'pokemon_detail_bloc.dart';

@freezed
sealed class PokemonDetailEvent with _$PokemonDetailEvent {
  const factory PokemonDetailEvent.loadPokemonDetail(int id) = _LoadPokemonDetail;
}
