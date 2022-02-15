import 'package:cubes/cubes.dart';
import 'package:examplecube/pokemon/pokemon_cube.dart';
import 'package:examplecube/pokemon/repository/model/pokemon.dart';
import 'package:examplecube/pokemon/widgets/pokemon_item_widget.dart';
import 'package:flutter/material.dart';

class PokemonScreen extends CubeWidget<PokemonCube> {
  @override
  Widget buildView(BuildContext context, PokemonCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemons with CubeWidget'),
      ),
      body: CFeedBackManager(
        snackBarControllers: [
          CSnackBarController<String>(
            observable: cube.snackBarController,
            builder: (value, context) => SnackBar(content: Text(value)),
          ),
        ],
        child: Stack(
          children: <Widget>[
            cube.list.build<List<Pokemon>>(
              (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (index >= data.length - 3) {
                      cube.fetchPokemonList(isMore: true);
                    }

                    return PokemonItemWidget(
                      item: data[index],
                    );
                  },
                );
              },
            ),
            cube.progress.build<bool>(
              (value) => value.conditional(
                match: Center(child: CircularProgressIndicator()),
              ),
              animate: true,
            ),
          ],
        ),
      ),
    );
  }
}
