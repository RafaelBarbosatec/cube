import 'package:cubes/cubes.dart';
import 'package:examplecube/pokemon/repository/model/pokemon.dart';
import 'package:examplecube/pokemon/repository/pokemon_repository.dart';

class PokemonCube extends Cube {
  final PokemonRepository repository;

  PokemonCube(this.repository);

  final list = ObservableValue<List<Pokemon>>(value: []);
  final progress = ObservableValue<bool>(value: false);
  int page = 0;

  @override
  void ready() {
    loadList();
    super.ready();
  }

  void loadList({bool isMore = false}) {
    if (progress.value) return;
    if (isMore) {
      page++;
    } else {
      page = 0;
    }
    progress.value = true;
    repository.getPokemonList(page: page).then((value) {
      if (isMore) {
        list.value.addAll(value);
        list.notify();
      } else {
        list.value = value;
      }
    }).catchError((error) {
      onError(error.toString());
    }).whenComplete(() {
      progress.value = false;
    });
  }
}
