import 'dart:math';

import 'package:cubes/cubes.dart';
import 'package:examplecube/counter_singleton/counter_singleton_cube.dart';
import 'package:flutter/material.dart';

class CounterSingletonWidget extends CubeWidget<CounterSingletonCube> {
  @override
  Widget buildView(BuildContext context, CounterSingletonCube cube) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            SizedBox(
              height: 20,
            ),
            cube.count.build<int>((value) {
              return Text(value.toString());
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: Random().nextInt(1000),
        onPressed: cube.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState(BuildContext context, CounterSingletonCube cube) {
    print('initState');
    super.initState(context, cube);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
}
