import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:flutter/material.dart';

class CounterScreenWithAnimation extends StatefulWidget {
  @override
  _CounterScreenWithAnimationState createState() =>
      _CounterScreenWithAnimationState();
}

class _CounterScreenWithAnimationState extends State<CounterScreenWithAnimation>
    with
        CubeStateMixin<CounterScreenWithAnimation, CounterCube>,
        TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curveAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _curveAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cube with animation'),
      ),
      body: ScaleTransition(
        scale: _curveAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('description_counter'),
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
  void onAction(CubeAction action) {
    print('onAction: $action');
  }
}
