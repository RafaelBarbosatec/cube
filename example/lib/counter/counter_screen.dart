import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
  @visibleForTesting
  static const KEY_FLOATING_BUTTON = Key('CounterScreen.KEY_FLOATING_BUTTON');

  @override
  Widget build(BuildContext context) {
    return CubeBuilder<CounterCube>(
      onAction: (cube, action) {
        if (action is CubeSuccessAction) {
          print('CubeSuccessAction: ${action.text}');
        }
        if (action is CubeErrorAction) {
          print('CubeErrorAction: ${action.text}');
        }
      },
      builder: (context, cube) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Cubes.getString('counter')),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(Cubes.getString('description_counter')),
                cube.count.build<int>((value) {
                  return Text(value.toString());
                }),
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
      },
    );
  }
}
