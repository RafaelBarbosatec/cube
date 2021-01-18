import 'package:cubes/cubes.dart';

class MsgAction extends CubeAction {
  final String text;

  MsgAction({this.text});

  @override
  String toString() {
    return 'MsgAction{text: $text}';
  }
}

class CounterCube extends Cube {
  final bool withDebounce;
  final count = ObservableValue<int>(value: 0);

  CounterCube({this.withDebounce = true});

  @override
  void onReady(Object arguments) {
    // do anythings when view is ready
    super.onReady(arguments);
  }

  void increment() {
    count.modify((value) => value + 1);
    if (count.value == 5) {
      onAction(MsgAction(text: "count five")); // to send action to view
    }

    if (count.value == 50) {
      onAction(MsgAction(text: "You are clicking too much o.O")); // to send action to view
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
