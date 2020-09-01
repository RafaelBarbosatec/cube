import 'package:flutter/foundation.dart';

class ObservableValue<T> extends ChangeNotifier {
  T _value;
  ObservableValue({T value}) {
    _value = value;
  }

  T get value => _value;

  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notify();
  }

  void notify() {
    if (hasListeners) {
      notifyListeners();
    }
  }
}
