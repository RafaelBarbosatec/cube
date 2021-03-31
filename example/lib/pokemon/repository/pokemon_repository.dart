import 'dart:convert';

import 'package:examplecube/pokemon/repository/model/pokemon.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  Future<List<Pokemon>>? getPokemonList({int page = 0, int limit = 20}) {
    String paramLimit = '';
    paramLimit = '&limit=$limit';
    String CORS = '';
    if (kIsWeb) {
      CORS = 'https://cors-anywhere.herokuapp.com/';
    }
    return http
        .get(Uri.parse(
            '${CORS}http://104.131.18.84/pokemon?page=$page$paramLimit'))
        .then((response) {
      return jsonDecode(response.body)['data']
          .map<Pokemon>((item) => Pokemon.fromJson(item))
          .toList();
    });
  }
}
