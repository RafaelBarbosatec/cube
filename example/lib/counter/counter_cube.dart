import 'package:cubes/cubes.dart';

class CounterCube extends Cube {
  final count = ObservableValue<int>(value: 0);

  @override
  void ready() {
    // do anythings when view is ready
    super.ready();
  }

  void increment() {
    count.value++;
    if (count.value == 5) {
      onAction({'key': 'param'}); // to send anything to view
    }
    if (count.value == 10) {
      onSuccess('Value iguals 10'); // to send the success message
    }
    if (count.value == 50) {
      onError('You are clicking too much o.O'); // to send the failure message
    }
  }
}
