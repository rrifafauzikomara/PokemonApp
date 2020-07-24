import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final ApiService apiService;

  PokemonBloc(this.apiService);

  @override
  PokemonState get initialState => InitialPokemonState();

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is LoadPokemon) {
      yield* _mapLoadPokemon();
    }
  }

  Stream<PokemonState> _mapLoadPokemon() async* {
    try {
      yield Loading();
      var response = await apiService.pokemonList();
      if (response.results.isEmpty) {
        yield NoData('No Data Pokemon');
      } else {
        yield HasData(response);
      }
    } on IOException catch (_) {
      yield NoInternetConnection('No Internet Connection');
    } on TimeoutException catch (_) {
      yield RequestTimeout('No Internet Connection');
    } catch (e) {
      yield Error(e.toString());
    }
  }
}
