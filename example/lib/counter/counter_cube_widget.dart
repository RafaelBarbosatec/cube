import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:flutter/material.dart';

class CounterCubeWidget extends CubeWidget<CounterCube> {
  @override
  Widget buildView(BuildContext context, CounterCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: 'Counter with CubeWidget'.title(context, color: Colors.white),
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
  }

  @override
  void onAction(BuildContext context, CounterCube cube, data) {
    print('onAction: $data');
    super.onAction(context, cube, data);
  }

  @override
  void onSuccess(BuildContext context, CounterCube cube, String text) {
    print('onSuccess: $text');
    super.onSuccess(context, cube, text);
  }

  @override
  void onError(BuildContext context, CounterCube cube, String text) {
    print('onError: $text');
    super.onError(context, cube, text);
  }
}
