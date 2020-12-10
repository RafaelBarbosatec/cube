import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:flutter/material.dart';

enum CounterCubeKeyAnimation { scaleController, scaleAnimation }

class CounterCubeWidgetAnimation extends CubeAnimationWidget<CounterCube> {
  @override
  void initState(BuildContext context, CounterCube cube) {
    final controller = confAnimationController(
      CounterCubeKeyAnimation.scaleController,
      duration: Duration(seconds: 1),
    );

    confAnimation(
      CounterCubeKeyAnimation.scaleAnimation,
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ),
    );

    controller.forward();
    super.initState(context, cube);
  }

  @override
  Widget buildView(BuildContext context, CounterCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CubeWidgetAnimation'),
      ),
      body: ScaleTransition(
        scale: getAnimation(CounterCubeKeyAnimation.scaleAnimation),
        child: Center(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cube.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void onAction(BuildContext context, CounterCube cube, CubeAction data) {
    print('onAction: $data');
    super.onAction(context, cube, data);
  }

  @override
  bool dispose(CounterCube cube) {
    return false;
  }
}
