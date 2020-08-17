import 'package:cubes/cubes.dart';
import 'package:examplecube/pokemon/pokemon_cube.dart';
import 'package:examplecube/pokemon/widgets/pokemon_item_widget.dart';
import 'package:flutter/material.dart';

class PokemonWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CubeBuilder<PokemonCube>(
      onError: (cube, text) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(content: Text(text)));
      },
      builder: (context, cube) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text('Pokemon'),
          ),
          body: Stack(
            children: <Widget>[
              cube.list.build((data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (index >= data.length - 3) {
                      cube.loadList(isMore: true);
                    }
                    return PokemonItemWidget(
                      item: data[index],
                      onClick: (item) {},
                    );
                  },
                );
              }),
              cube.progress.build((value) {
                return value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox.shrink();
              })
            ],
          ),
        );
      },
    );
  }
}
