import 'package:cubes/src/cube.dart';

class CubeMemoryContainer {
  static final CubeMemoryContainer instance = CubeMemoryContainer._internal();
  static List<Cube> _cubes = List();

  CubeMemoryContainer._internal();
  void add(Cube cube) => _cubes.add(cube);
  void remove(Cube cube) => _cubes.remove(cube);
  T get<T extends Cube>() {
    return _cubes.firstWhere((element) => element is T, orElse: () => null);
  }
}
