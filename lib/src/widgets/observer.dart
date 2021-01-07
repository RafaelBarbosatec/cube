import 'package:cubes/src/observable/observable_value.dart';
import 'package:cubes/src/util/state_mixin.dart';
import 'package:flutter/material.dart';

typedef ObserverBuilder<T> = Widget Function(T value);
typedef WhenBuild<T> = bool Function(T last, T next);

class CObserver<T> extends StatefulWidget {
  const CObserver({
    Key key,
    @required this.observable,
    @required this.builder,
    this.animate = false,
    this.when,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final ObservableValue<T> observable;
  final ObserverBuilder<T> builder;
  final WhenBuild<T> when;
  final bool animate;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;
  final Duration duration;

  @override
  _CObserverState<T> createState() => _CObserverState<T>();
}

class _CObserverState<T> extends State<CObserver> with StateMixin {
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
    if (widgetObserver?.when?.call(widget.observable.lastValue, widget.observable.value) ?? true) {
      postFrame(() => setState(() {}));
    }
  }

  CObserver<T> get widgetObserver => (widget as CObserver<T>);
}
