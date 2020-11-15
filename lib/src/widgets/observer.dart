import 'package:cubes/src/observable/observable_value.dart';
import 'package:cubes/src/util/state_mixin.dart';
import 'package:flutter/material.dart';

typedef ObserverBuilder<T> = Widget Function(T value);
typedef WhenCondition<T> = bool Function(T oldValue, T newValue);

class Observer<T> extends StatefulWidget {
  const Observer({
    Key key,
    @required this.observable,
    @required this.builder,
    this.animate = false,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.duration = const Duration(milliseconds: 300),
    this.when,
  }) : super(key: key);

  final ObservableValue<T> observable;
  final ObserverBuilder<T> builder;
  final WhenCondition<T> when;
  final bool animate;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;
  final Duration duration;

  @override
  _ObserverState<T> createState() => _ObserverState<T>();
}

class _ObserverState<T> extends State<Observer> with StateMixin {
  @override
  void initState() {
    widget.observable?.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.observable?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      return AnimatedSwitcher(
        duration: widget.duration,
        transitionBuilder: widget.transitionBuilder,
        child: widgetObserver.builder(widget.observable.value),
      );
    }
    return widgetObserver.builder(widget.observable.value);
  }

  void _listener() {
    if (widgetObserver.when?.call(widget.observable.lastValue, widget.observable.value) ?? true) {
      postFrame(() => setState(() {}));
    }
  }

  Observer<T> get widgetObserver => (widget as Observer<T>);
}
