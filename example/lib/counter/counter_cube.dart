import 'package:cubes/cubes.dart';

class CounterCube extends Cube {
  final count = ObservableValue<int>(initValue: 0);

  @override
  void ready() {
    // do anythings when view is ready
    super.ready();
  }

  void increment() {
    count.set(count.value + 1);
    if (count.value == 5) {
      onAction({'key': 'param'}); // to send anythings to view
    }
    if (count.value == 10) {
      onSuccess('Value iguals 10'); // to send message of the success
    }
    if (count.value == 50) {
      onError(
          'You are clicking too much o.O'); // to send message of the failure
    }
  }
}
