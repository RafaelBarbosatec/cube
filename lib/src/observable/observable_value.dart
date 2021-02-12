import 'package:flutter/foundation.dart';

typedef ModifyValue<T> = T Function(T value);

class ObservableValue<T> extends ChangeNotifier {
  T _value;
  T _lastValue;

  ObservableValue({T value}) {
    _value = value;
  }

  T get value => _value;
  T get lastValue => _lastValue;

  // ignore: avoid_setters_without_getters
  set setValueWithoutNotify(T value) => _value = value;

  void _setValueAndNotify(T newValue) {
    if (T is List) {
      _lastValue = List.of(_value as List) as T;
    } else if (T is Map) {
      _lastValue = Map.of(_value as Map) as T;
    } else {
      _lastValue = _value;
    }
    _value = newValue;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } on Exception catch (_) {
      print('A $runtimeType was used after being disposed');
    }
  }

  @override
  void dispose() {
    try {
      super.dispose();
    } on Exception catch (_) {
      print('Once you have called dispose() on a $runtimeType, it can no longer be used.');
    }
  }

  /// uses to update value
  void update(T value) => _setValueAndNotify(value);

  /// user do modify value. recommended return new instance (use copyWith if is possible).
  void modify(ModifyValue<T> modify) => _setValueAndNotify(modify(value));
}
