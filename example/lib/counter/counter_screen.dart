import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
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
            title: getString('counter').title(context, color: Colors.white),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getString('description_counter').body(context),
                cube.count.build<int>((value) {
                  return value.toString().body(context);
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
