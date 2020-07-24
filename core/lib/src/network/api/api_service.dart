import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  Client _client = Client();

  static final String _baseUrl = 'https://pokeapi.co/api/v2/';

  Future<List<Pokemon>> pokemonList(int startIndex, int limit) async {
    final response =
        await _client.get(_baseUrl + 'pokemon?limit=$startIndex&offset=$limit');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return List<Pokemon>.from(data["results"].map((x) => Pokemon.fromJson(x)));
    } else {
      throw Exception('Failed to load pokemon list');
    }
  }

  Future<PokemonDetail> pokemonDetail(String url) async {
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return PokemonDetail.fromJson(data);
    } else {
      throw Exception('Failed to load pokemon detail');
    }
  }
}
