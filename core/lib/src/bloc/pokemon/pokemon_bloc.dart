import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final ApiService apiService;

  PokemonBloc({@required this.apiService});

  @override
  Stream<PokemonState> transformEvents(Stream<PokemonEvent> events,
      Stream<PokemonState> Function(PokemonEvent p1) next) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  PokemonState get initialState => InitialPokemonState();

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    final currentState = state;
    if (event is LoadPokemon && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InitialPokemonState) {
          final response = await apiService.pokemonList(10, 15);
          yield PokemonHasData(result: response, hasReachedMax: false);
          return;
        }
        if (currentState is PokemonHasData) {
          final response =
              await apiService.pokemonList(currentState.result.length, 20);
          yield response.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PokemonHasData(
                  result: currentState.result + response,
                  hasReachedMax: false,
                );
        }
      } on IOException catch (_) {
        yield NoInternetConnection('No Internet Connection');
      } on TimeoutException catch (_) {
        yield RequestTimeout('Request Timeout');
      } catch (e) {
        yield Error(e.toString());
      }
    } else if (event is LoadPokemonDetail) {
      yield* _mapLoadPokemonDetail(event.url);
    }
  }

  bool _hasReachedMax(PokemonState state) =>
      state is PokemonHasData && state.hasReachedMax;

  Stream<PokemonState> _mapLoadPokemonDetail(String url) async* {
    try {
      var response = await apiService.pokemonDetail(url);
      yield PokemonDetailHasData(response);
    } on IOException catch (_) {
      yield NoInternetConnection('No Internet Connection');
    } on TimeoutException catch (_) {
      yield RequestTimeout('No Internet Connection');
    } catch (e) {
      yield Error(e.toString());
    }
  }
}
