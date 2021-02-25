import 'package:cubes/cubes.dart';

class CounterSingletonCube extends Cube {
  final count = 0.obsValue;

  void increment() => count.modify((value) => value + 1);
}
