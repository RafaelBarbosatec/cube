import 'package:cubes/cubes.dart';

class TextFormFieldCube extends Cube {
  final textFieldControl = CTextFormFieldControl().obsValue;

  void cleanText() {
    textFieldControl.modify((value) => value.copyWith(text: ''));
  }

  void changeText() {
    textFieldControl.modify((value) => value.copyWith(text: 'Change Text'));
  }

  void setError() {
    textFieldControl.modify((value) => value.copyWith(error: 'error example'));
  }

  void enable() {
    textFieldControl.modify((value) => value.copyWith(enable: true));
  }

  void disable() {
    textFieldControl.modify((value) => value.copyWith(enable: false));
  }

  void changeObscureText() {
    textFieldControl.modify((value) => value.copyWith(obscureText: !value.obscureText));
  }
}
