import 'package:flutter/foundation.dart';

import '../cubes.dart';
import 'util/debouncer.dart';

/// Base to Actions
abstract class CubeAction {}

/// Function to notify Actions
typedef OnActionChanged<A extends Cube, CubeAction> = void Function(
  A valueA,
  CubeAction valueB,
);

/// Base to create Cube
abstract class Cube {
  List<OnActionChanged<Cube, CubeAction>>? _onActionListeners;
  Map<dynamic, Debounce>? _debounceMap;
  Map<ObservableValue, VoidCallback>? _listenersObservableMap;
  OnActionChanged? _cubeActionListener;

  /// called when the view is ready
  /// [arguments] if passed through CubeBuilder, if not, get arguments
  /// from `ModalRoute.of(context).settings.arguments;`
  void onReady(Object? arguments) {}

  /// called when the cube is destroyed
  void dispose() {
    _disposeListeners();
  }

  /// Add OnActionListener
  void addOnActionListener<T extends Cube>(
    OnActionChanged<T, CubeAction>? listener,
  ) {
    if (_onActionListeners == null) _onActionListeners = [];
    _onActionListeners?.add(listener as OnActionChanged<Cube, CubeAction>);
  }

  /// Remove OnActionListener
  void removeOnActionListener<T extends Cube>(
      OnActionChanged<T, CubeAction>? listener) {
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
  ///
  @protected
  void runDebounce(
    dynamic identify,
    VoidCallback call, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    try {
      if (_debounceMap == null) _debounceMap = {};
      if (_debounceMap?.containsKey(identify) == true) {
        if (_debounceMap![identify]?.delay != duration) {
          _debounceMap![identify] = Debounce(duration);
        }
        _debounceMap![identify]?.call(call);
      } else {
        _debounceMap![identify] = Debounce(duration);
        _debounceMap![identify]?.call(call);
      }
    } on Exception catch (e) {
      print('[ERROR]runDebounce: $e');
    }
  }

  /// Uses to listen `ObservableValue` inner Cube
  @protected
  void listen<T>(ObservableValue<T> observableValue, ValueChanged<T> listener) {
    if (_listenersObservableMap == null) _listenersObservableMap = {};
    _listenersObservableMap![observableValue] = () {
      listener(observableValue.value);
    };
    observableValue.addListener(_listenersObservableMap![observableValue]!);
  }

  /// Remove listeners created on `listen`
  void _disposeListeners() {
    removeOnActionListener(_cubeActionListener);
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
