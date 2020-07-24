import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class InitialPokemonState extends PokemonState {}

class HasData extends PokemonState {
  final List<Pokemon> result;
  final bool hasReachedMax;

  HasData({this.result, this.hasReachedMax});

  HasData copyWith({
    List<Pokemon> result,
    bool hasReachedMax,
  }) {
    return HasData(
      result: result ?? this.result,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [result, hasReachedMax];

  @override
  String toString() =>
      'Has Data --> { data: ${result.length}, hasReachedMax: $hasReachedMax }';
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
