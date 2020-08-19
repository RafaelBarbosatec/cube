typedef FeedbackChanged<A, B> = void Function(A valueA, B valueB);

abstract class Cube {
  List<FeedbackChanged<dynamic, String>> _onSuccessListeners;
  List<FeedbackChanged<dynamic, String>> _onErrorListeners;
  List<FeedbackChanged<dynamic, dynamic>> _onActionListeners;

  // initial data if passed through CubeBuilder
  dynamic data;

  // called when the view is ready
  void ready() {}

  // called when the cube is destroyed
  void dispose() {}

  void addOnSuccessListener<T extends Cube>(
    FeedbackChanged<T, String> listener,
  ) {
    if (listener != null) {
      if (_onSuccessListeners == null) _onSuccessListeners = List();
      _onSuccessListeners.add(listener);
    }
  }

  void addOnErrorListener<T extends Cube>(
    FeedbackChanged<T, String> listener,
  ) {
    if (listener != null) {
      if (_onErrorListeners == null) _onErrorListeners = List();
      _onErrorListeners.add(listener);
    }
  }

  void addOnActionListener<T extends Cube>(
    FeedbackChanged<T, String> listener,
  ) {
    if (listener != null) {
      if (_onActionListeners == null) _onActionListeners = List();
      _onActionListeners.add(listener);
    }
  }

  void removeOnSuccessListener<T extends Cube>(
      FeedbackChanged<T, String> listener) {
    _onSuccessListeners?.remove(listener);
  }

  void removeOnErrorListener<T extends Cube>(
      FeedbackChanged<T, String> listener) {
    _onErrorListeners?.remove(listener);
  }

  void removeOnActionListener<T extends Cube>(
      FeedbackChanged<T, String> listener) {
    _onActionListeners?.remove(listener);
  }

  // Method to send the success message
  void onSuccess(String msg) {
    _onSuccessListeners?.forEach((element) => element(this, msg));
  }

  // Method to send the failure message
  void onError(String msg) {
    _onErrorListeners?.forEach((element) => element(this, msg));
  }

  // Method to send anything to view
  void onAction(dynamic action) {
    _onActionListeners?.forEach((element) => element(this, action));
  }
}
