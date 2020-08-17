import 'package:cubes/cubes.dart';

class CounterCube extends Cube {
  final count = ObservableValue<int>(initValue: 0);

  void increment() {
    count.set(count.value + 1);
    if (count.value == 10) {
      onSuccess('Value iguals 10');
    }
    if (count.value == 50) {
      onError('You are clicking too much o.O');
    }
  }
}
