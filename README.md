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

  // Example register singleton Cube
  // registerCube((i) => CounterCube(),isSingleton: true);

  // Example register repositories or anything
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
  final count = ObservableValue<int>(value: 0);

    @override
    void ready() {
      // do anything when view is ready
      super.ready();
    }

    void increment() {
      count.value++;
      if (count.value == 5) {
        onAction({'key': 'param'}); // Method to send anything to view
      }
      if (count.value == 10) {
        onSuccess('Value iguals 10'); // Method to send the success message
      }
      if (count.value == 50) {
        onError('You are clicking too much o.O'); // Method to send the failure message
      }

      // example apply debounce
       runDebounce(
        'increment', // identify
        ()  => print(count.value),
        duration: Duration(seconds: 1),
      );
    }
}

class Home extends StatelessWidget {
  final String title;

  const Home({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CubeBuilder<CounterCube>(
      onSuccess: (cube, text) {
        print('onSuccess: $text');
      },
      onError: (cube, text) {
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

## Testing

```dart

import 'package:flutter_test/flutter_test.dart';

void main() {
  CounterCube cube;
  setUp(() {
    cube = CounterCube();
  });

  tearDown(() {
    cube?.dispose();
  });
  test('initial value', () {
    expect(cube.count.value, 0);
  });

  test('increment value', () {
    cube.increment();
    expect(cube.count.value, 1);
  });

  test('increment value 3 times', () {
    cube.increment();
    cube.increment();
    cube.increment();
    expect(cube.count.value, 3);
  });
}

```

Example with asynchronous call [here](https://github.com/RafaelBarbosatec/cube/blob/master/example/test/pokemon_test.dart)

