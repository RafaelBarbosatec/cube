import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:flutter/material.dart';

enum CounterCubeKeyAnimation { scaleController, scaleAnimation }

class CounterCubeWidget extends CubeWidgetAnimation<CounterCube> {
  @override
  void initState(
    BuildContext context,
    CounterCube cube,
    TickerProvider ticker,
  ) {
    final controller = confAnimationController(
        CounterCubeKeyAnimation.scaleController, ticker,
        duration: Duration(seconds: 1));

    setAnimation(
      CounterCubeKeyAnimation.scaleAnimation,
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ),
    );

    controller.forward();
    super.initState(context, cube, ticker);
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
              Text(getString('description_counter')),
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
