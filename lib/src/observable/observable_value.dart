import 'package:flutter/foundation.dart';

class ObservableValue<T> extends ChangeNotifier {
  T _lastValue;
  T _value;
  ObservableValue({T value}) {
    _lastValue = value;
    _value = value;
  }

  T get value => _value;
  T get lastValue => _lastValue;

  set value(T newValue) {
    if (_value == newValue) return;
    _lastValue = _value;
    _value = newValue;
    notify();
  }

  void notify() {
    if (hasListeners) {
      notifyListeners();
    }
  }
}
