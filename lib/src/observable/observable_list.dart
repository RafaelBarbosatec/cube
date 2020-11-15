import 'package:cubes/src/observable/observable_value.dart';

class ObservableList<T> extends ObservableValue<List<T>> {
  ObservableList({Iterable<T> value}) {
    this.value = value;
  }

  /// add element in list and notify listeners
  void add(T value) {
    this.value?.add(value);
    notify();
  }

  /// add element list in list and notify listeners
  void addAll(Iterable<T> value) {
    this.value?.addAll(value);
    notify();
  }

  /// clear list and notify listeners
  void clear() {
    this.value?.clear();
    notify();
  }

  /// remove in list and notify listeners
  void remove(T value) {
    this.value?.remove(value);
    notify();
  }

  /// remove element by index in list and notify listeners
  void removeAt(int index) {
    this.value?.removeAt(index);
    notify();
  }

  /// remove element in list and notify listeners
  void removeWhere(bool test(T element)) {
    this.value?.removeWhere(test);
    notify();
  }

  /// remove last element in list and notify listeners
  void removeLast() {
    this.value?.removeLast();
    notify();
  }

  /// remove element by range in list and notify listeners
  void removeRange(int start, int end) {
    this.value?.removeRange(start, end);
    notify();
  }

  /// replace elements in list and notify listeners
  void replaceRange(int start, int end, Iterable<T> replacement) {
    this.value?.replaceRange(start, end, replacement);
    notify();
  }

  /// get if list is empty
  bool get isEmpty => this.value?.isEmpty;

  /// get if list is not empty
  bool get isNotEmpty => !isEmpty;

  /// get size list
  int get length => this.value?.length;

  /// get first item
  T get first => this.value?.first;

  /// get last item
  T get last => this.value?.last;
}
