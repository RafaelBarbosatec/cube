import 'package:flutter/foundation.dart';

typedef ModifyValue<T> = T Function(T value);

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

  void update({@required T value}) => this.value = value;
  void modify({@required ModifyValue modify}) => this.value = modify(this.value);

  void notify() {
    if (hasListeners) {
      notifyListeners();
    }
  }
}
