import 'package:clean/core/error/error_handler.dart';
import 'package:clean/features/home/domain/entity/pokemon_entity.dart';
import 'package:clean/features/home/domain/usecase/get_home_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeListUsecase _getPokemonListUsecase;

  static const int _pageSize = 20;

  HomeBloc(this._getPokemonListUsecase) : super(const HomeState.initial()) {
    on<_LoadPokemonList>(_onLoadPokemonList);
    on<_LoadMorePokemon>(_onLoadMorePokemon);
    on<_RefreshPokemonList>(_onRefreshPokemonList);
  }

  Future<void> _onLoadPokemonList(
    _LoadPokemonList event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());

    final result = await _getPokemonListUsecase(limit: _pageSize, offset: 0);

    result.fold(
      (failure) => emit(HomeState.error(ErrorHandler.getErrorMessage(failure))),
      (pokemonListEntity) => emit(
        HomeState.loaded(
          pokemonList: pokemonListEntity.results,
          hasMore: pokemonListEntity.next != null,
          currentOffset: _pageSize,
        ),
      ),
    );
  }

  Future<void> _onLoadMorePokemon(
    _LoadMorePokemon event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    emit(HomeState.loadingMore(
      pokemonList: currentState.pokemonList,
      currentOffset: currentState.currentOffset,
    ));

    final result = await _getPokemonListUsecase(
      limit: _pageSize,
      offset: currentState.currentOffset,
    );

    result.fold(
      (failure) => emit(
        HomeState.loaded(
          pokemonList: currentState.pokemonList,
          hasMore: currentState.hasMore,
          currentOffset: currentState.currentOffset,
        ),
      ),
      (pokemonListEntity) => emit(
        HomeState.loaded(
          pokemonList: [...currentState.pokemonList, ...pokemonListEntity.results],
          hasMore: pokemonListEntity.next != null,
          currentOffset: currentState.currentOffset + _pageSize,
        ),
      ),
    );
  }

  Future<void> _onRefreshPokemonList(
    _RefreshPokemonList event,
    Emitter<HomeState> emit,
  ) async {
    final result = await _getPokemonListUsecase(limit: _pageSize, offset: 0);

    result.fold(
      (failure) {
        if (state is _Loaded) return;
        emit(HomeState.error(ErrorHandler.getErrorMessage(failure)));
      },
      (pokemonListEntity) => emit(
        HomeState.loaded(
          pokemonList: pokemonListEntity.results,
          hasMore: pokemonListEntity.next != null,
          currentOffset: _pageSize,
        ),
      ),
    );
  }
}
