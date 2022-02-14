import 'package:cubes/cubes.dart';
import 'package:examplecube/todo/todo_cube.dart';
import 'package:flutter/material.dart';

class TodoRegister extends CubeWidget<TodoCube> {
  final formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();

  @override
  Widget buildView(BuildContext context, TodoCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo register'),
      ),
      body: Form(
        key: formKey,
        child: Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(hintText: 'todo'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(context.theme.primaryColor),
                    ),
                    child: Text('Save'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cube.addTodo(textEditingController.text);
                        context.pop(textEditingController.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
