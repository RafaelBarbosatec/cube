import 'package:cubes/cubes.dart';

class TodoCube extends Cube {
  final todoList = ['first TODO', 'second TODO'].obsValue;

  void addTodo(String todo) => todoList.add(todo);

  void delete(String todo) => todoList.remove(todo);
}
