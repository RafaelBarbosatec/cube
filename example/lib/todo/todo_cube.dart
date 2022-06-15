import 'package:cubes/cubes.dart';

class TodoCube extends Cube with CubeNavigation {
  final todoList = ['first TODO', 'second TODO'].obs;

  void addTodo(String todo) => todoList.add(todo);

  void delete(String todo) => todoList.remove(todo);
}
