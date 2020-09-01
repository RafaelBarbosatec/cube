import 'package:cubes/src/observable/observable_value.dart';

class ObservableList<T> extends ObservableValue<List<T>> {
  ObservableList({Iterable<T> value}) {
    this.value = value;
  }
  void add(T value) {
    this.value?.add(value);
    notify();
  }

  void addAll(Iterable<T> value) {
    this.value?.addAll(value);
    notify();
  }

  void clear() {
    this.value?.clear();
    notify();
  }

  void remove(T value) {
    this.value?.remove(value);
    notify();
  }

  void removeAt(int index) {
    this.value?.removeAt(index);
    notify();
  }

  void removeWhere(bool test(T element)) {
    this.value?.removeWhere(test);
    notify();
  }

  void removeLast() {
    this.value?.removeLast();
    notify();
  }

  void removeRange(int start, int end) {
    this.value?.removeRange(start, end);
    notify();
  }

  void replaceRange(int start, int end, Iterable<T> replacement) {
    this.value?.replaceRange(start, end, replacement);
    notify();
  }

  int get length => this.value?.length;
}
