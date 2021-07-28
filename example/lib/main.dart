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
  Cubes.registerDependency((i) => CounterCube());
  Cubes.registerDependency((i) => CounterSingletonCube(), isSingleton: true);
  Cubes.registerDependency((i) => TodoCube(), isSingleton: true);
  Cubes.registerDependency((i) => PokemonCube(i.getDependency()));
  Cubes.registerDependency((i) => PokemonRepository());
  Cubes.registerDependency((i) => FeedbackManagerCube());
  Cubes.registerDependency((i) => TextFormFieldCube());
  Cubes.registerDependency((i) => CounterSimpleCube());
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
  const Home({Key? key}) : super(key: key);
  @override
  // ignore: long-method
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Cubes.getString('welcome')),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                child: Text(Cubes.getString('counter')),
                onPressed: () {
                  context.goTo(
                    CounterScreen(),
                    settings: RouteSettings(arguments: {'name': 'rafael'}),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Counter. Cube in StatefulWidget'),
                onPressed: () {
                  context.goTo(CounterScreenWithAnimation());
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Counter. Using SimpleCube'),
                onPressed: () {
                  context.goTo(
                    CounterSimpleCubeScreen(),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Pokemons'),
                onPressed: () {
                  context.goTo(PokemonScreen());
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(Cubes.getString('singleton')),
                onPressed: () {
                  context.goTo(ScreenCounterSingleton());
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Todo'),
                onPressed: () {
                  context.goTo(TodoList());
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('FeedBackManager'),
                onPressed: () {
                  context.goTo(FeedbackManagerScreen());
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('CTextFormField'),
                onPressed: () {
                  context.goTo(TextFormFieldScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
