import 'package:cubes/cubes.dart';
import 'package:examplecube/text_form_field/text_form_field_cube.dart';
import 'package:flutter/material.dart';

class TextFormFieldScreen extends CubeWidget<TextFormFieldCube> {
  @override
  Widget buildView(BuildContext context, TextFormFieldCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CTexFormField'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CTextFormField(
                observable: cube.textFieldControl,
                decoration: InputDecoration(hintText: 'Digite algo'),
                obscureTextButtonConfiguration: CObscureTextButtonConfiguration(
                  align: CObscureTextAlign.right,
                  iconHide: Icon(Icons.visibility_off_outlined),
                  iconShow: Icon(Icons.visibility_outlined),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Wrap(
                children: [
                  RaisedButton(child: Text('Clean text'), onPressed: cube.cleanText),
                  SizedBox(width: 10),
                  RaisedButton(child: Text('Change text'), onPressed: cube.changeText),
                  SizedBox(width: 10),
                  RaisedButton(child: Text('Set error'), onPressed: cube.setError),
                  SizedBox(width: 10),
                  RaisedButton(child: Text('enable'), onPressed: cube.enable),
                  SizedBox(width: 10),
                  RaisedButton(child: Text('disable'), onPressed: cube.disable),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
