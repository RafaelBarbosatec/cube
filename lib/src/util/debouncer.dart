import 'dart:async';

import 'package:flutter/foundation.dart';

/// Class used to apply "debounce"
class Debounce {
  final Duration delay;
  Timer? _timer;

  /// Debounce constructor
  Debounce(this.delay);

  /// Method used to call method and reset time if it is not finished
  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
