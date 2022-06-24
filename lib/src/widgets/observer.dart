import 'package:flutter/material.dart';

import '../observable/observable_value.dart';
import '../util/state_mixin.dart';

typedef ObserverBuilder<T> = Widget? Function(T value);
typedef WhenBuild<T> = bool Function(T last, T next);
typedef WithoutContextWidgetBuilder = Widget Function();

/// Widget responsible for building another widget
/// through ObservableValue updates
class CObserver<T> extends StatefulWidget {
  const CObserver({
    Key? key,
    required this.observable,
    required this.builder,
    this.emptyBuilder,
    this.animate = false,
    this.when,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final ObservableValue<T> observable;
  final ObserverBuilder<T> builder;
  final WithoutContextWidgetBuilder? emptyBuilder;
  final WhenBuild<T>? when;
  final bool animate;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;
  final Duration duration;

  @override
  _CObserverState<T> createState() => _CObserverState<T>();
}

class _CObserverState<T> extends State<CObserver> {
  @override
  void initState() {
    widget.observable.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.observable.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      return AnimatedSwitcher(
        duration: widget.duration,
        transitionBuilder: widget.transitionBuilder,
        child: _buildChild(),
      );
    }

    return _buildChild();
  }

  Widget _buildChild() {
    return widgetObserver.builder(widget.observable.value) ??
        (widgetObserver.emptyBuilder?.call() ?? SizedBox.shrink());
  }

  void _listener() {
    final canRebuild = widgetObserver.when?.call(
          widget.observable.lastValue,
          widget.observable.value,
        ) ??
        true;
    if (canRebuild) {
      // ignore: no-empty-block
      postFrame(() => setState(() {}));
    }
  }

  CObserver<T> get widgetObserver => (widget as CObserver<T>);
}
