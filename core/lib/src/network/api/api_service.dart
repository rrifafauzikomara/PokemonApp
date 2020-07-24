import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  Client _client = Client();

  static final String _baseUrl =
      'https://pokeapi.co/api/v2/pokemon?limit=10&offset=15';

  Future<PokemonResponse> pokemonList() async {
    final response = await _client.get(_baseUrl);
    if (response.statusCode == 200) {
      return PokemonResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
