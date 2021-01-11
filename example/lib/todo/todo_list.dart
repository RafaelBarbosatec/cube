import 'package:cubes/cubes.dart';
import 'package:examplecube/todo/todo_cube.dart';
import 'package:examplecube/todo/todo_register.dart';
import 'package:flutter/material.dart';

class TodoList extends CubeWidget<TodoCube> {
  @override
  Widget buildView(BuildContext context, TodoCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: CAnimatedList<String>(
        observable: cube.todoList,
        itemBuilder: (context, item, animation, type) {
          if (type == TypeAnimationListEnum.add) {
            return ScaleTransition(
              scale: animation,
              child: _buildItem(item, cube),
            );
          } else {
            return SizeTransition(
              sizeFactor: animation,
              child: _buildItem(item, cube),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goTo(TodoRegister());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), //
    );
  }

  Widget _buildItem(String text, TodoCube cube) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(child: Text(text)),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                cube.delete(text);
              },
            )
          ],
        ),
      ),
    );
  }
}
