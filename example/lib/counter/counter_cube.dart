import 'package:cubes/cubes.dart';
import 'package:flutter/src/widgets/framework.dart';

class MsgAction extends CubeAction {
  final String? text;

  MsgAction({this.text});

  @override
  String toString() {
    return 'MsgAction{text: $text}';
  }

  @override
  void onExecute(BuildContext context) {
    print(this);
  }
}

class CounterCube extends Cube {
  final bool withDebounce;
  final count = 0.obs;

  CounterCube({this.withDebounce = true});

  @override
  Future<void> onReady(Object? arguments) {
    // do anythings when view is ready
    return super.onReady(arguments);
  }

  void increment() {
    count.modify((value) => value + 1);
    if (count.value == 5) {
      sendAction(MsgAction(text: "count five")); // to send action to view
    }

    if (count.value == 50) {
      sendAction(
        MsgAction(text: "You are clicking too much o.O"),
      ); // to send action to view
    }

    if (withDebounce) {
      runDebounce(
        'increment',
        () => print(count.value),
        duration: Duration(seconds: 1),
      );
    }
  }
}
