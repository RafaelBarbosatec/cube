import 'package:cubes/cubes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ObservableList<int> _observableListValue;
  List<int> _valueNotify;
  setUp(() {
    _observableListValue = ObservableList(value: []);
    _observableListValue.addListener(() {
      _valueNotify = _observableListValue.value;
    });
  });

  tearDown(() {
    _valueNotify = null;
    _observableListValue.dispose();
  });

  test('verify initial value', () {
    expect(_observableListValue.value, []);
  });

  test('verify update list', () {
    _observableListValue.update([3, 2, 1]);
    expect(_valueNotify, [3, 2, 1]);
  });

  test('verify add value in list', () {
    _observableListValue.add(1);
    expect(_valueNotify, [1]);
    _observableListValue.add(3);
    expect(_valueNotify, [1, 3]);
  });

  test('verify addAll in list', () {
    _observableListValue.addAll([3, 2, 1]);
    expect(_valueNotify, [3, 2, 1]);
  });

  test('verify remove value in list', () {
    _observableListValue.update([3, 2, 1]);
    _observableListValue.remove(1);
    expect(_valueNotify, [3, 2]);
  });

  test('verify clean list', () {
    _observableListValue.update([3, 2, 1]);
    expect(_valueNotify, [3, 2, 1]);
    _observableListValue.clear();
    expect(_valueNotify, []);
  });

  test('verify modifyitem', () {
    _observableListValue.update([3, 2, 1]);
    expect(_valueNotify, [3, 2, 1]);
    _observableListValue.modifyItem(0, (value) => value + 1);
    expect(_valueNotify, [4, 2, 1]);
    _observableListValue.removeAt(0);
    expect(_valueNotify, [2, 1]);
    _observableListValue.modifyItem(0, (value) => value + 3);
    expect(_valueNotify, [5, 1]);
  });
}
