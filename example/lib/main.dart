import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/Counter.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:examplecube/pokemon/pokemon_cube.dart';
import 'package:examplecube/pokemon/pokemon_widget.dart';
import 'package:examplecube/pokemon/repository/pokemon_repository.dart';
import 'package:flutter/material.dart';

void main() {
  // register cube
  registerCube((i) => CounterCube());
  registerCube((i) => PokemonCube(i.get()));
  registerSingletonDependency((i) => PokemonRepository());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatelessWidget {
  final String title;

  const Home({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text('Counter'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Counter()),
                );
              },
            ),
            RaisedButton(
              child: Text('Pokemons'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PokemonWidget()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
