import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class LoadPokemon extends PokemonEvent {}

class LoadPokemonDetail extends PokemonEvent {
  final String url;

  LoadPokemonDetail({@required this.url});

  @override
  List<Object> get props => [url];
}
