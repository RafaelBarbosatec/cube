import 'package:cubes/cubes.dart';

class CounterSimpleCube extends SimpleCube {
  final count = 0.obsValue;

  void increment() {
    count.modify((value) => value + 1);
  }
}
