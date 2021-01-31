import 'package:cubes/cubes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ObservableValue<int> _observableValue;
  int _valueNotify;
  setUp(() {
    _observableValue = ObservableValue(value: 0);
    _observableValue.addListener(() {
      _valueNotify = _observableValue.value;
    });
  });

  tearDown(() {
    _observableValue.dispose();
  });

  test('verify initial value', () {
    expect(_observableValue.value, 0);
  });

  test('verify change value with update', () {
    _observableValue.update(10);
    expect(_observableValue.value, 10);
  });

  test('verify change value with modify', () {
    _observableValue.modify((value) => value + 10);
    expect(_observableValue.value, 10);
  });

  test('verify lastValue', () {
    _observableValue.update(10);
    _observableValue.update(30);
    _observableValue.update(40);
    expect(_observableValue.lastValue, 30);
    expect(_observableValue.value, 40);
  });

  test('verify value in listeners', () {
    _observableValue.update(10);
    expect(_valueNotify, 10);
    _observableValue.modify((value) => value + 10);
    expect(_valueNotify, 20);
  });
}
