import 'package:cubes/cubes.dart';
import 'package:cubes/src/util/cube_memory_container.dart';
import 'package:cubes/src/util/debouncer.dart';
import 'package:flutter/cupertino.dart';

typedef OnActionChanged<A extends Cube, CubeAction> = void Function(A valueA, CubeAction valueB);

abstract class Cube {
  List<OnActionChanged> _onActionListeners;
  Map<dynamic, Debounce> _debounceMap;
  Map<ObservableValue, VoidCallback> _listenersObservableMap;

  /// initial data if passed through CubeBuilder
  dynamic data;

  /// called when the view is ready
  void ready() {
    CubeMemoryContainer.instance.add(this);
  }

  /// called when the cube is destroyed
  void dispose() {
    _disposeListen();
    CubeMemoryContainer.instance.remove(this);
  }

  /// Add OnActionListener
  void addOnActionListener<T extends Cube>(
    OnActionChanged<T, String> listener,
  ) {
    if (listener != null) {
      if (_onActionListeners == null) _onActionListeners = List();
      _onActionListeners.add(listener);
    }
  }

  /// Remove OnActionListener
  void removeOnActionListener<T extends Cube>(OnActionChanged<T, String> listener) {
    _onActionListeners?.remove(listener);
  }

  /// Method to send anything to view
  void onAction(CubeAction action) {
    _onActionListeners?.forEach((element) => element(this, action));
  }

  ///
  /// Uses to apply debounce.
  ///
  /// Example:
  ///
  ///   runDebounce(
  ///      'increment',
  ///      () => print(count.value),
  ///      duration: Duration(seconds: 1),
  ///    );
  void runDebounce(
    dynamic identify,
    Function call, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    try {
      if (_debounceMap == null) _debounceMap = Map();
      if (_debounceMap.containsKey(identify)) {
        if (_debounceMap[identify].delay != duration) {
          _debounceMap[identify] = Debounce(duration);
        }
        _debounceMap[identify].call(call);
      } else {
        _debounceMap[identify] = Debounce(duration);
        _debounceMap[identify].call(call);
      }
    } catch (e) {
      print('runDebounce: $e');
    }
  }

  /// Uses to get the Cube ready in memory by type
  T getCubeIsReady<T extends Cube>() {
    return CubeMemoryContainer.instance.get<T>();
  }

  /// Uses to get the Cubes ready in memory by type
  Iterable<T> getCubesAreReady<T extends Cube>() {
    return CubeMemoryContainer.instance.getCubes<T>();
  }

  void listen<T>(ObservableValue<T> observableValue, ValueChanged<T> listener) {
    if (_listenersObservableMap == null) _listenersObservableMap = Map();
    _listenersObservableMap[observableValue] = () => listener(observableValue.value);
    observableValue.addListener(_listenersObservableMap[observableValue]);
  }

  void _disposeListen() {
    _listenersObservableMap.forEach((key, value) {
      key.removeListener(value);
    });
  }
}
