import 'package:flutter/cupertino.dart';

class ObservableValue<T> extends ChangeNotifier {
  T _value;
  ObservableValue({T value}) {
    _value = value;
  }

  T get value => _value;

  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void notify() {
    if (hasListeners) {
      notifyListeners();
    }
  }
}
