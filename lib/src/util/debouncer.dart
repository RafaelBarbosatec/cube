import 'dart:async';

class Debounce {
  final Duration delay;
  Timer _timer;

  Debounce(this.delay);

  void call(Function action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
