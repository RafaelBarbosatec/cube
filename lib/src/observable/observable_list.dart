import 'observable_value.dart';

/// Class that represents our list-type observable
class ObservableList<T> extends ObservableValue<List<T>> {
  /// Constructor to init ObservableValue with value
  ObservableList({Iterable<T> value}) {
    setValueWithoutNotify = value;
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
    value?.clear();
    notifyListeners();
  }

  /// remove in list and notify listeners
  void remove(T value) {
    this.value?.remove(value);
    notifyListeners();
  }

  /// remove element by index in list and notify listeners
  void removeAt(int index) {
    value?.removeAt(index);
    notifyListeners();
  }

  /// remove element in list and notify listeners
  void removeWhere(bool test(T element)) {
    value?.removeWhere(test);
    notifyListeners();
  }

  /// remove last element in list and notify listeners
  void removeLast() {
    value?.removeLast();
    notifyListeners();
  }

  /// remove element by range in list and notify listeners
  void removeRange(int start, int end) {
    value?.removeRange(start, end);
    notifyListeners();
  }

  /// insert element in the index
  void insert(int index, T element) {
    value?.insert(index, element);
    notifyListeners();
  }

  /// insert element list in the index
  void insertAll(int index, Iterable<T> iterable) {
    value?.insertAll(index, iterable);
    notifyListeners();
  }

  /// replace elements in list and notify listeners
  void replaceRange(int start, int end, Iterable<T> replacement) {
    value?.replaceRange(start, end, replacement);
    notifyListeners();
  }

  /// use to modify specific item in the list
  void modifyItem(int index, T modify(T value)) {
    if (value != null && value.length > index) {
      value[index] = modify(value[index]);
      notifyListeners();
    }
  }

  /// get if list is empty
  bool get isEmpty => value?.isEmpty;

  /// get if list is not empty
  bool get isNotEmpty => !isEmpty;

  /// get size list
  int get length => value?.length;

  /// get first item
  T get first => value?.first;

  /// get last item
  T get last => value?.last;
}
