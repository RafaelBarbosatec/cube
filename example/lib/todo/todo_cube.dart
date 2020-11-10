import 'package:cubes/cubes.dart';

class TodoCube extends Cube {
  final todoList = ObservableList<String>(value: ['first TODO', 'second TODO']);

  void addTodo(String todo) => todoList.add(todo);

  void delete(String todo) => todoList.remove(todo);
}
