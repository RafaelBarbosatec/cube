import 'dart:math';

import 'package:cubes/cubes.dart';
import 'package:examplecube/counter_singleton/counter_singleton_cube.dart';
import 'package:flutter/material.dart';

class CounterSingleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubeBuilder<CounterSingletonCube>(
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                'You have pushed the button this many times:'
                    .body(context, textAlign: TextAlign.center),
                SizedBox(
                  height: 20,
                ),
                cube.count.build<int>((value) {
                  return value.toString().body(context);
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
      },
    );
  }
}
