import 'package:cubes/src/observable_value.dart';
import 'package:cubes/src/util/functions.dart';
import 'package:flutter/material.dart';

typedef ObserverBuilder<T> = Widget Function(T value);

class Observer<T> extends StatefulWidget {
  const Observer({
    Key key,
    @required this.observable,
    @required this.builder,
    this.animate = false,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final ObservableValue<T> observable;
  final ObserverBuilder<T> builder;
  final bool animate;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;
  final Duration duration;

  @override
  _ObserverState createState() => _ObserverState();
}

class _ObserverState extends State<Observer> {
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
        child: widget.builder(widget.observable.value),
      );
    }
    return widget.builder(widget.observable.value);
  }

  void _listener() {
    postFrame(() {
      if (mounted) {
        setState(() {});
      }
    });
  }
}
