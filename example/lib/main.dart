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
  Cubes.putDependency((i) => CounterCube());
  Cubes.putDependency(
    (i) => CounterSingletonCube(),
    type: DependencyRegisterType.singleton,
  );
  Cubes.putDependency(
    (i) => TodoCube(),
    type: DependencyRegisterType.lazySingleton,
  );
  Cubes.putDependency((i) => PokemonCube(i.getDependency()));
  Cubes.putDependency(
    (i) => PokemonRepository(),
    type: DependencyRegisterType.lazySingleton,
  );
  Cubes.putDependency((i) => FeedbackManagerCube());
  Cubes.putDependency((i) => TextFormFieldCube());
  Cubes.putDependency((i) => CounterSimpleCube());
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
        title: Text('welcome'.tr(params: {'name': 'folks'.tr()})),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                child: Text('counter'.tr()),
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
                child: Text('singleton'.tr()),
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
