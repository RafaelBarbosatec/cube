import 'package:cubes/cubes.dart';
import 'package:examplecube/pokemon/repository/model/pokemon.dart';
import 'package:examplecube/pokemon/repository/pokemon_repository.dart';

class PokemonCube extends Cube {
  final PokemonRepository repository;

  PokemonCube(this.repository);

  final list = ObservableValue<List<Pokemon>>(initValue: []);
  final progress = ObservableValue<bool>(initValue: false);
  int page = 0;
  List<Pokemon> localList = List();

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
    progress.set(true);
    repository.getPokemonList(page: page).then((value) {
      if (isMore) {
        localList.addAll(value);
      } else {
        localList = value;
      }
      list.set(localList);
    }).catchError((error) {
      onError(error.toString());
    }).whenComplete(() {
      progress.set(false);
    });
  }
}
