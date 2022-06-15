# Cubes examples

- [Counter (Using CubeWidget)](#counter)
- [Counter (Using CubeConsumer)](#counter)


## Counter (Using CubeWidget)

```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

void main() {

  Cubes.registerFactory((i) => CounterCube());

  runApp(MaterialApp(
      title: 'Cube Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(),
    ),
  );
}

class CounterCube extends Cube {

  final count = 0.obs;

  void increment() {
    count.modify((value) => value + 1); // or count.update(newValue);
  }

}

class CounterScreen extends CubeWidget<CounterCube> {
  @override
  Widget buildView(BuildContext context, CounterCube cube) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            SizedBox(height: 20),
            cube.count.build<int>((value) {
              return Text(value.toString());
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cube.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

```

## Counter (Using CubeConsumer)

```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

void main() {

  Cubes.registerFactory((i) => CounterCube());

  runApp(MaterialApp(
      title: 'Cube Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(),
    ),
  );
}

class CounterCube extends Cube {

  final count = 0.obs;

  void increment() {
    count.modify((value) => value + 1); // or count.update(newValue);
  }

}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubeConsumer<CounterCube>(
      builder: (BuildContext context, CounterCube cube) {
        return Scaffold(
          appBar: AppBar(
            title: Text('counter'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('You have pushed the button this many times:'),
                cube.count.build<int>(
                  (value) => Text(value.toString()),
                ),
              ],
            ),
          ),
           floatingActionButton: FloatingActionButton(
              onPressed: cube.increment,
              child: Icon(Icons.add),
            ),
        );
      },
    );
  }
}

```
