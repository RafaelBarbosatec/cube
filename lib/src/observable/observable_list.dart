import 'package:cubes/src/observable/observable_value.dart';

class ObservableList<T> extends ObservableValue<List<T>> {
  ObservableList({Iterable<T> value}) {
    this.setInitialValue(value);
  }

  /// add element in list and notify listeners
  void add(T value) {
    this.value?.add(value);
    notifyListeners();
  }

  /// add element list in list and notify listeners
  void addAll(Iterable<T> value) {
    this.value?.addAll(value);
    notifyListeners();
  }

  /// clear list and notify listeners
  void clear() {
    this.value?.clear();
    notifyListeners();
  }

  /// remove in list and notify listeners
  void remove(T value) {
    this.value?.remove(value);
    notifyListeners();
  }

  /// remove element by index in list and notify listeners
  void removeAt(int index) {
    this.value?.removeAt(index);
    notifyListeners();
  }

  /// remove element in list and notify listeners
  void removeWhere(bool test(T element)) {
    this.value?.removeWhere(test);
    notifyListeners();
  }

  /// remove last element in list and notify listeners
  void removeLast() {
    this.value?.removeLast();
    notifyListeners();
  }

  /// remove element by range in list and notify listeners
  void removeRange(int start, int end) {
    this.value?.removeRange(start, end);
    notifyListeners();
  }

  /// insert element in the index
  void insert(int index, T element) {
    this.value?.insert(index, element);
    notifyListeners();
  }

  /// insert element list in the index
  void insertAll(int index, Iterable<T> iterable) {
    this.value?.insertAll(index, iterable);
    notifyListeners();
  }

  /// replace elements in list and notify listeners
  void replaceRange(int start, int end, Iterable<T> replacement) {
    this.value?.replaceRange(start, end, replacement);
    notifyListeners();
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
