import 'package:flutter/cupertino.dart';

class ObservableValue<T> extends ChangeNotifier {
  T _data;
  ObservableValue({T initValue}) {
    _data = initValue;
  }

  void set(T value) {
    _data = value;
    if (hasListeners) {
      notifyListeners();
    }
  }

  T get value => _data;
}
