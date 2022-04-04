import 'package:cubes/cubes.dart';

class CounterSimpleCube extends SimpleCube {
  final count = 0.obs;

  void increment() {
    count.modify((value) => value + 1);
  }
}
