import 'package:flutter/cupertino.dart';

abstract class Cube {
  List<ValueChanged<String>> _onSuccessListeners = List();
  List<ValueChanged<String>> _onErrorListeners = List();
  dynamic data;

  void init() {}
  void dispose() {}

  void addOnSuccessListener(ValueChanged<String> listener) {
    if (listener != null) _onSuccessListeners.add(listener);
  }

  void addOnErrorListener(ValueChanged<String> listener) {
    if (listener != null) _onErrorListeners.add(listener);
  }

  void removeOnSuccessListener(ValueChanged<String> listener) {
    _onSuccessListeners.remove(listener);
  }

  void removeOnErrorListener(ValueChanged<String> listener) {
    _onErrorListeners.remove(listener);
  }

  void onSuccess(String msg) {
    _onSuccessListeners.forEach((element) => element(msg));
  }

  void onError(String msg) {
    _onErrorListeners.forEach((element) => element(msg));
  }
}
