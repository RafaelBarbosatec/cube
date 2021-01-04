import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:flutter/material.dart';

class CounterScreen extends CubeWidget<CounterCube> {
  @visibleForTesting
  static const KEY_FLOATING_BUTTON = Key('CounterScreen.KEY_FLOATING_BUTTON');

  @override
  Widget buildView(BuildContext context, CounterCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Cubes.getString('counter')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Cubes.getString('description_counter')),
            cube.count.build<int>(
              (value) => Text(value.toString()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: KEY_FLOATING_BUTTON,
        onPressed: cube.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
