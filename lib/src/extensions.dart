import 'package:cubes/src/observable_value.dart';
import 'package:cubes/src/observer.dart';

extension ObservableValueExtensions on ObservableValue {
  Observer build(ObserverBuilder build) {
    return Observer(observable: this, builder: build);
  }
}
