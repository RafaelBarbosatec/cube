import 'dart:async';

/// Class used to apply "debounce"
class Debounce {
  final Duration delay;
  Timer _timer;

  /// Debounce constructor
  Debounce(this.delay);

  /// Method used to call method and reset time if it is not finished
  void call(Function action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
