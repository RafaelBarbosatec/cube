import 'package:cubes/cubes.dart';
import 'package:examplecube/todo/todo_cube.dart';
import 'package:flutter/material.dart';

class TodoRegister extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Todo register'.title(context, color: Colors.white),
      ),
      body: CubeBuilder<TodoCube>(
        builder: (context, cube) {
          return Form(
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
                        if (value.isEmpty) {
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
                      child: RaisedButton(
                        color: context.theme.primaryColor,
                        child: 'Save'.body(context, color: Colors.white),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            cube.addTodo(textEditingController.text);
                            context.pop();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
