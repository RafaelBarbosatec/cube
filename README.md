# Cube

Simple State Manager

```dart

import 'package:cube/cube.dart';
import 'package:flutter/material.dart';

void main() {
  registerCube((i) => CountCube());
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

class CountCube extends Cube {
  ObservableValue<int> count = ObservableValue(initValue: 0);

  void increment() {
    count.set(count.value + 1);
    if (count.value == 10) {
      onSuccess('Value iguals 10');
    }
    if (count.value == 50) {
      onError('You are clicking too much o.O');
    }
  }
}

class Home extends StatelessWidget {
  final String title;

  const Home({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CubeBuilder<CountCube>(
      onSuccess: (text) {
        print('onSuccess: $text');
      },
      onError: (text) {
        print('onError: $text');
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
                cube.count.build((value) {
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
