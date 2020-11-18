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
    _lastValue = _value;
    _value = newValue;
    notifyListeners();
  }

  void update(T value) => _setValueAndNotify(value);
  void modify(ModifyValue<T> modify) => _setValueAndNotify(modify(value));
}
