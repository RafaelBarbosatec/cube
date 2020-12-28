import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
  @visibleForTesting
  static const KEY_FLOATING_BUTTON = Key('CounterScreen.KEY_FLOATING_BUTTON');

  @override
  Widget build(BuildContext context) {
    return CubeBuilder<CounterCube>(
      onAction: (cube, action) => print(action),
      dispose: (cube) => true,
      builder: (context, cube) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Cubes.getString('counter')),
          ),
          body: FeedbackManager(
            bottomSheetControllers: [
              BottomSheetController(
                observable: cube.bottomSheet,
                builder: (data, context) {
                  return Container(height: 200, child: Center(child: Text('BottomSheetController: $data')));
                },
              )
            ],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(Cubes.getString('description_counter')),
                  cube.count.build<int>(
                    (value) {
                      return Text(value.toString());
                    },
                  ),
                ],
              ),
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
