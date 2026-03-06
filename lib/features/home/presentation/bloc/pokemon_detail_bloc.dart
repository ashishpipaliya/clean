import 'package:clean/core/error/error_handler.dart';
import 'package:clean/features/home/domain/entity/pokemon_detail_entity.dart';
import 'package:clean/features/home/domain/usecase/get_home_detail_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';
part 'pokemon_detail_bloc.freezed.dart';

@injectable
class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final GetHomeDetailUsecase _getPokemonDetailUsecase;

  PokemonDetailBloc(this._getPokemonDetailUsecase)
      : super(const PokemonDetailState.initial()) {
    on<_LoadPokemonDetail>(_onLoadPokemonDetail);
  }

  Future<void> _onLoadPokemonDetail(
    _LoadPokemonDetail event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(const PokemonDetailState.loading());

    final result = await _getPokemonDetailUsecase(event.id);

    result.fold(
      (failure) => emit(PokemonDetailState.failure(ErrorHandler.getErrorMessage(failure))),
      (pokemonDetail) => emit(PokemonDetailState.success(pokemonDetail)),
    );
  }
}
