import 'package:cube/src/observable_value.dart';
import 'package:cube/src/observer.dart';

extension ObservableValueExtensions on ObservableValue {
  Observer build(ObserverBuilder build) {
    return Observer(observable: this, builder: build);
  }
}
