import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

void postFrame(FrameCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback(callback);
}
