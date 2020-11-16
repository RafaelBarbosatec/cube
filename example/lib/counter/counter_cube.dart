import 'package:cubes/cubes.dart';

class CounterCube extends Cube {
  final bool withDebounce;
  final count = ObservableValue<int>(value: 0);

  CounterCube({this.withDebounce = true});

  @override
  void ready() {
    // do anythings when view is ready
    super.ready();
  }

  void increment() {
    count.modify((value) => value + 1);
    if (count.value == 5) {
      onAction(CubeSuccessAction(text: "count five")); // to send action to view
    }

    if (count.value == 50) {
      onAction(CubeErrorAction(text: "You are clicking too much o.O")); // to send action to view
    }

    if (withDebounce) {
      runDebounce(
        'increment',
        () => print(count.value),
        duration: Duration(milliseconds: 300),
      );
    }
  }
}
