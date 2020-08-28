import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:examplecube/counter/counter_screen.dart';
import 'package:examplecube/counter_singleton/counter_singleton_cube.dart';
import 'package:examplecube/counter_singleton/screen_counter_singleton.dart';
import 'package:examplecube/pokemon/pokemon_cube.dart';
import 'package:examplecube/pokemon/pokemon_screen.dart';
import 'package:examplecube/pokemon/repository/pokemon_repository.dart';
import 'package:examplecube/todo/todo_cube.dart';
import 'package:examplecube/todo/todo_list.dart';
import 'package:flutter/material.dart';

void main() {
  // register cube
  registerCube((i) => CounterCube());
  registerCube((i) => CounterSingletonCube(), isSingleton: true);
  registerCube((i) => TodoCube(), isSingleton: true);
  registerCube((i) => PokemonCube(i.get()));
  registerSingletonDependency((i) => PokemonRepository());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final cubeLocation = CubesLocalizationDelegate(
    [
      Locale('en', 'US'),
      Locale('pt', 'BR'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubes Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: cubeLocation.delegates,
      supportedLocales: cubeLocation.supportedLocations,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getString('welcome').title(context, color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: getString('counter').body(context),
              onPressed: () {
                context.goTo(CounterScreen());
              },
            ),
            RaisedButton(
              child: 'Pokemons'.body(context),
              onPressed: () {
                context.goTo(PokemonScreen());
              },
            ),
            RaisedButton(
              child: getString('singleton').body(context),
              onPressed: () {
                context.goTo(ScreenCounterSingleton());
              },
            ),
            RaisedButton(
              child: 'Todo'.body(context),
              onPressed: () {
                context.goTo(TodoList());
              },
            ),
          ],
        ),
      ),
    );
  }
}
