[![pub package](https://img.shields.io/pub/v/cubes.svg)](https://pub.dartlang.org/packages/cubes)

<img src="https://github.com/RafaelBarbosatec/cube/blob/master/media/icon.png" height=80><img/>
# Cubes

Simple State Manager

## Install
To use this plugin, add `cubes` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Usage

```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

void main() {
  // register cube
  registerCube((i) => CounterCube());

  // Example register repositories or anythings
  // registerSingletonDependency((i) => SingletonRepository(i.get());
  // registerDependency((i) => FactoryRepository(i.get());

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

class CounterCube extends Cube {
  final count = ObservableValue<int>(initValue: 0);

    @override
    void ready() {
      // do anythings when view is ready
      super.ready();
    }

    void increment() {
      count.set(count.value + 1);
      if (count.value == 5) {
        onAction({'key': 'param'}); // to send anythings to view
      }
      if (count.value == 10) {
        onSuccess('Value iguals 10'); // to send message of the success
      }
      if (count.value == 50) {
        onError('You are clicking too much o.O'); // to send message of the failure
      }
    }
}

class Home extends StatelessWidget {
  final String title;

  const Home({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CubeBuilder<CounterCube>(
      onSuccess: (text) {
        print('onSuccess: $text');
      },
      onError: (text) {
        print('onError: $text');
      },
      onAction: (cube, data) {
        print('onAction: $data');
      },
      builder: (context, cube) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                cube.count.build<int>((value) {
                  return Text(value.toString());
                }),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cube.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}

```
