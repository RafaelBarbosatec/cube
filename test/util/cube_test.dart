import 'package:cubes/cubes.dart';

class ActionTest extends CubeAction {}

class CubeTest extends Cube {
  void sendAction(CubeAction action) {
    onAction(action);
  }
}
