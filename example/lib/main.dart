import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_screen.dart';
import 'package:examplecube/counter/counter_screen_animation.dart';
import 'package:examplecube/counter_singleton/screen_counter_singleton.dart';
import 'package:examplecube/feedback_manager/feedback_manager_cube.dart';
import 'package:examplecube/feedback_manager/feedback_manager_screen.dart';
import 'package:examplecube/pokemon/pokemon_cube.dart';
import 'package:examplecube/pokemon/pokemon_screen.dart';
import 'package:examplecube/pokemon/repository/pokemon_repository.dart';
import 'package:examplecube/text_form_field/text_form_field_screen.dart';
import 'package:examplecube/todo/todo_cube.dart';
import 'package:examplecube/todo/todo_list.dart';
import 'package:flutter/material.dart';

import 'counter/counter_cube.dart';
import 'counter_simple_cube/counter_simple_cube.dart';
import 'counter_simple_cube/counter_simple_cube_screen.dart';
import 'counter_singleton/counter_singleton_cube.dart';
import 'text_form_field/text_form_field_cube.dart';

void main() {
  // register cube
  Cubes.registerFactory((i) => CounterCube());
  Cubes.registerSingleton(CounterSingletonCube());
  Cubes.registerLazySingleton((i) => TodoCube());
  Cubes.registerFactory((i) => PokemonCube(i.get()));
  Cubes.registerLazySingleton((i) => PokemonRepository());
  Cubes.registerFactory((i) => FeedbackManagerCube());
  Cubes.registerFactory((i) => TextFormFieldCube());
  Cubes.registerFactory((i) => CounterSimpleCube());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubes Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  // ignore: long-method
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                child: Text('counter'),
                onPressed: () {
                  context.goTo(
                    (_) => CounterScreen(),
                    settings: RouteSettings(arguments: {'name': 'rafael'}),
                  );
                },
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                child: Text('Counter. Cube in StatefulWidget'),
                onPressed: () {
                  context.goTo((_) => CounterScreenWithAnimation());
                },
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                child: Text('Counter. Using SimpleCube'),
                onPressed: () {
                  context.goTo(
                    (_) => CounterSimpleCubeScreen(),
                  );
                },
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                child: Text('Pokemons'),
                onPressed: () {
                  context.goTo((_) => PokemonScreen());
                },
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                child: Text('singleton'),
                onPressed: () {
                  context.goTo((_) => ScreenCounterSingleton());
                },
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                child: Text('Todo'),
                onPressed: () {
                  context.goTo((_) => TodoList());
                },
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                child: Text('FeedBackManager'),
                onPressed: () {
                  context.goTo((_) => FeedbackManagerScreen());
                },
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                child: Text('CTextFormField'),
                onPressed: () {
                  context.goTo((_) => TextFormFieldScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
