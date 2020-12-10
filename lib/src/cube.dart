import 'package:cubes/cubes.dart';
import 'package:cubes/src/util/cube_memory_container.dart';
import 'package:cubes/src/util/debouncer.dart';
import 'package:flutter/cupertino.dart';

typedef OnActionChanged<A extends Cube, CubeAction> = void Function(A valueA, CubeAction valueB);

abstract class Cube {
  List<OnActionChanged> _onActionListeners;
  Map<dynamic, Debounce> _debounceMap;
  Map<ObservableValue, VoidCallback> _listenersObservableMap;
  OnActionChanged _cubeActionListener;
  bool isReady = false;

  /// initial data if passed through CubeBuilder
  dynamic data;

  /// called when the view is ready
  void ready() {
    CubeMemoryContainer.instance.add(this);
    isReady = true;
  }

  /// called when the cube is destroyed
  void dispose() {
    _disposeListen();
    removeOnActionListener(_cubeActionListener);
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
  @protected
  void onAction(CubeAction action) {
    if (_onActionListeners?.isEmpty == true) return;
    _onActionListeners?.last(this, action);
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
  @protected
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
  @protected
  T getCubeIsReady<T extends Cube>() {
    return CubeMemoryContainer.instance.get<T>();
  }

  /// Uses to get the Cubes ready in memory by type
  @protected
  Iterable<T> getCubesAreReady<T extends Cube>() {
    return CubeMemoryContainer.instance.getCubes<T>();
  }

  /// Uses to listen `ObservableValue` inner Cube
  @protected
  void listen<T>(ObservableValue<T> observableValue, ValueChanged<T> listener) {
    if (_listenersObservableMap == null) _listenersObservableMap = Map();
    _listenersObservableMap[observableValue] = () => listener(observableValue.value);
    observableValue.addListener(_listenersObservableMap[observableValue]);
  }

  /// Remove listeners created on `listen`
  void _disposeListen() {
    _listenersObservableMap?.forEach((key, value) {
      key.removeListener(value);
    });
  }

  /// Uses to listen `CubeAction` sended to view
  @protected
  void listenActions(ValueChanged<CubeAction> listener) {
    _cubeActionListener = (cube, action) => listener(action);
    addOnActionListener(_cubeActionListener);
  }
}
