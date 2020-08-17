typedef FeedbackChanged<A, B> = void Function(A valueA, B valueB);

abstract class Cube {
  List<FeedbackChanged<dynamic, String>> _onSuccessListeners = List();
  List<FeedbackChanged<dynamic, String>> _onErrorListeners = List();
  dynamic data;

  void ready() {}
  void dispose() {}

  void addOnSuccessListener<T extends Cube>(
      FeedbackChanged<T, String> listener) {
    if (listener != null) _onSuccessListeners.add(listener);
  }

  void addOnErrorListener<T extends Cube>(FeedbackChanged<T, String> listener) {
    if (listener != null) _onErrorListeners.add(listener);
  }

  void removeOnSuccessListener<T extends Cube>(
      FeedbackChanged<T, String> listener) {
    _onSuccessListeners.remove(listener);
  }

  void removeOnErrorListener<T extends Cube>(
      FeedbackChanged<T, String> listener) {
    _onErrorListeners.remove(listener);
  }

  void onSuccess(String msg) {
    _onSuccessListeners.forEach((element) => element(this, msg));
  }

  void onError(String msg) {
    _onErrorListeners.forEach((element) => element(this, msg));
  }
}
