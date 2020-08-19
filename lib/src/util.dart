import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

void postFrame(VoidCallback callback) {
  Future.delayed(Duration.zero, callback);
}
