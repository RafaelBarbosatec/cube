import 'dart:async';

import 'package:cubes/cubes.dart';
import 'package:examplecube/pokemon/repository/model/pokemon.dart';
import 'package:examplecube/pokemon/repository/pokemon_repository.dart';

class PokemonCube extends Cube {
  static const LIMIT_PAGE = 20;
  final PokemonRepository repository;

  PokemonCube(this.repository);

  final list = <Pokemon>[].obs;
  final progress = false.obs;
  final snackBarController = CFeedBackControl<String>().obs;

  @override
  Future<void> onReady(Object? arguments) {
    fetchPokemonList();
    return super.onReady(arguments);
  }

  void fetchPokemonList({bool isMore = false}) {
    if (progress.value) return;
    int page = 0;
    if (isMore) {
      page = (list.length ~/ LIMIT_PAGE) + 1;
    }
    progress.value = true;
    repository.getPokemonList(page: page, limit: LIMIT_PAGE)?.then((value) {
      if (isMore) {
        list.addAll(value);
      } else {
        list.value = value;
      }
    }).catchError((error) {
      snackBarController.show(data: error.toString());
    }).whenComplete(() => progress.value = false);
  }
}
