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

  @protected
  void setInitialValue(T value) {
    _value = value;
  }

  void _setValueAndNotify(T newValue) {
    if (T is List) {
      _lastValue = List.of(_value as List) as T;
    } else {
      _lastValue = _value;
    }
    _value = newValue;
    notifyListeners();
  }

  /// uses to update value
  void update(T value) => _setValueAndNotify(value);

  /// user do modify value. recommended return new instance (use copyWith if is possible).
  void modify(ModifyValue<T> modify) => _setValueAndNotify(modify(value));
}
