import 'package:cubes/cubes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ObservableList<int> _observableValue;
  List<int> _valueNotify;
  setUp(() {
    _observableValue = ObservableList(value: []);
    _observableValue.addListener(() {
      _valueNotify = _observableValue.value;
    });
  });

  tearDown(() {
    _valueNotify = null;
    _observableValue.dispose();
  });

  test('verify initial value', () {
    expect(_observableValue.value, []);
  });

  test('verify update list', () {
    _observableValue.update([3, 2, 1]);
    expect(_valueNotify, [3, 2, 1]);
  });

  test('verify add value in list', () {
    _observableValue.add(1);
    expect(_valueNotify, [1]);
    _observableValue.add(3);
    expect(_valueNotify, [1, 3]);
  });

  test('verify addAll in list', () {
    _observableValue.addAll([3, 2, 1]);
    expect(_valueNotify, [3, 2, 1]);
  });

  test('verify remove value in list', () {
    _observableValue.update([3, 2, 1]);
    _observableValue.remove(1);
    expect(_valueNotify, [3, 2]);
  });

  test('verify clean list', () {
    _observableValue.update([3, 2, 1]);
    expect(_valueNotify, [3, 2, 1]);
    _observableValue.clear();
    expect(_valueNotify, []);
  });

  test('verify modifyitem', () {
    _observableValue.update([3, 2, 1]);
    expect(_valueNotify, [3, 2, 1]);
    _observableValue.modifyItem(0, (value) => 5);
    expect(_valueNotify, [5, 2, 1]);
    _observableValue.removeAt(0);
    expect(_valueNotify, [2, 1]);
    _observableValue.modifyItem(0, (value) => 5);
    expect(_valueNotify, [5, 1]);
  });
}
