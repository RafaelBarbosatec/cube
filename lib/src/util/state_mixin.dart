import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void postFrame(VoidCallback callback) {
    Future.delayed(Duration.zero, () {
      if (mounted) callback();
    });
  }
}
