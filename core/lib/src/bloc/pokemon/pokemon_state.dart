import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class InitialPokemonState extends PokemonState {}

class Loading extends PokemonState {}

class HasData extends PokemonState {
  final PokemonResponse response;

  HasData([this.response]);

  @override
  List<Object> get props => [response];
}

class NoData extends PokemonState {
  final String message;

  NoData(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'No Data --> message: $message';
}

class NoInternetConnection extends PokemonState {
  final String message;

  NoInternetConnection(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'No Internet Connection --> message: $message';
}

class RequestTimeout extends PokemonState {
  final String message;

  RequestTimeout(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Request Timeout --> message: $message';
}

class Error extends PokemonState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Error --> message: $message';
}
