import 'package:cubes/cubes.dart';

class TextFormFieldCube extends Cube {
  final ObservableValue<CTextFormFieldControl> textFieldControl = ObservableValue(value: CTextFormFieldControl());

  void cleanText() {
    textFieldControl.modify((value) => value.copyWith(value: ''));
  }

  void changeText() {
    textFieldControl.modify((value) => value.copyWith(value: 'Change Text'));
  }

  void setError() {
    textFieldControl.modify((value) => value.copyWith(error: 'error example'));
  }

  void cleanError() {
    textFieldControl.modify((value) => value.copyWith(error: ''));
  }

  void enable() {
    textFieldControl.modify((value) => value.copyWith(enable: true));
  }

  void disable() {
    textFieldControl.modify((value) => value.copyWith(enable: false));
  }
}