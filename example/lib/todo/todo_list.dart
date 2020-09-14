import 'package:cubes/cubes.dart';
import 'package:examplecube/todo/todo_cube.dart';
import 'package:examplecube/todo/todo_register.dart';
import 'package:flutter/material.dart';

class TodoList extends CubeWidget<TodoCube> {
  @override
  Widget buildView(BuildContext context, TodoCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: 'Todo List'.title(context, color: Colors.white),
      ),
      body: cube.todoList.build<List<String>>(
        (value) {
          if (value.isEmpty) {
            return Center(
              child: 'Empty list'.body(context),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(child: value[index].body(context)),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          cube.delete(value[index]);
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        animate: true,
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
}
