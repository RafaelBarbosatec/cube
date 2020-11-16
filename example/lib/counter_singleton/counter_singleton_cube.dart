import 'package:cubes/cubes.dart';

class CounterSingletonCube extends Cube {
  final count = ObservableValue<int>(value: 0);

  void increment() => count..modify((value) => value + 1);
}
