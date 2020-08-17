import 'dart:convert';

import 'package:examplecube/pokemon/repository/model/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  Future<List<Pokemon>> getPokemonList({int page = 0, int limit = 20}) {
    String paramLimit = '';
    if (limit != null) paramLimit = '&limit=$limit';
    return http.get('http://104.131.18.84/pokemon?page=$page$paramLimit').then(
        (response) => jsonDecode(response.body)['data']
            .map<Pokemon>((item) => Pokemon.fromJson(item))
            .toList());
  }
}
