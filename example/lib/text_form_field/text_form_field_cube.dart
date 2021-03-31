import 'package:cubes/cubes.dart';

class TextFormFieldCube extends Cube {
  final textFieldControl = CTextFormFieldControl.empty().obsValue;

  void cleanText() {
    textFieldControl.text = '';
  }

  void changeText() {
    textFieldControl.text = 'Change Text';
  }

  void setError() {
    textFieldControl.error = 'error example';
  }

  void enable() {
    textFieldControl.enable = true;
  }

  void disable() {
    textFieldControl.enable = false;
  }

  void changeObscureText() {
    textFieldControl.enableObscureText = !textFieldControl.enableObscureText;
  }
}
