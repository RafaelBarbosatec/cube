import 'package:cubes/src/observable_value.dart';
import 'package:cubes/src/observer.dart';

extension ObservableValueExtensions on ObservableValue {
  Observer build<T>(ObserverBuilder<T> build) {
    return Observer(
      observable: this,
      builder: (value) => build(value as T),
    );
  }
}
