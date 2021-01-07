import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:examplecube/counter/counter_screen.dart';
import 'package:examplecube/counter/counter_screen_animation.dart';
import 'package:examplecube/counter_singleton/counter_singleton_cube.dart';
import 'package:examplecube/counter_singleton/screen_counter_singleton.dart';
import 'package:examplecube/feedback_manager/feedback_manager_cube.dart';
import 'package:examplecube/feedback_manager/feedback_manager_screen.dart';
import 'package:examplecube/pokemon/pokemon_cube.dart';
import 'package:examplecube/pokemon/pokemon_screen.dart';
import 'package:examplecube/pokemon/repository/pokemon_repository.dart';
import 'package:examplecube/text_form_field/text_form_field_cube.dart';
import 'package:examplecube/text_form_field/text_form_field_screen.dart';
import 'package:examplecube/todo/todo_cube.dart';
import 'package:examplecube/todo/todo_list.dart';
import 'package:flutter/material.dart';

void main() {
  // register cube
  Cubes.registerDependency((i) => CounterCube());
  Cubes.registerDependency((i) => CounterSingletonCube(), isSingleton: true);
  Cubes.registerDependency((i) => TodoCube(), isSingleton: true);
  Cubes.registerDependency((i) => PokemonCube(i.getDependency()));
  Cubes.registerDependency((i) => PokemonRepository());
  Cubes.registerDependency((i) => FeedbackManagerCube());
  Cubes.registerDependency((i) => TextFormFieldCube());

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
        title: Text(Cubes.getString('welcome')),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text(Cubes.getString('counter')),
              onPressed: () {
                context.goTo(CounterScreen(), settings: RouteSettings(arguments: {'name': 'rafael'}));
              },
            ),
            RaisedButton(
              child: Text('Counter. Cube in StatefulWidget'),
              onPressed: () {
                context.goTo(CounterScreenWithAnimation());
              },
            ),
            RaisedButton(
              child: Text('Pokemons'),
              onPressed: () {
                context.goTo(PokemonScreen());
              },
            ),
            RaisedButton(
              child: Text(Cubes.getString('singleton')),
              onPressed: () {
                context.goTo(ScreenCounterSingleton());
              },
            ),
            RaisedButton(
              child: Text('Todo'),
              onPressed: () {
                context.goTo(TodoList());
              },
            ),
            RaisedButton(
              child: Text('FeedBackManager'),
              onPressed: () {
                context.goTo(FeedbackManagerScreen());
              },
            ),
            RaisedButton(
              child: Text('CTextFormField'),
              onPressed: () {
                context.goTo(TextFormFieldScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
