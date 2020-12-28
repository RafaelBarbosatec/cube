import 'package:cubes/cubes.dart';

class CounterCube extends Cube {
  final bool withDebounce;
  final count = ObservableValue<int>(value: 0);
  final bottomSheet = ObservableValue<FeedBackControl<String>>(value: FeedBackControl());

  CounterCube({this.withDebounce = true});

  @override
  void ready() {
    // do anythings when view is ready
    super.ready();
  }

  void increment() {
    count.modify((value) => value + 1);
    if (count.value == 5) {
      onAction(CubeSuccessAction(text: "count five")); // to send action to view
    }

    if (count.value == 50) {
      onAction(CubeErrorAction(text: "You are clicking too much o.O")); // to send action to view
    }

    if (count.value % 2 == 0) {
      bottomSheet.modify((value) => value.copyWith(show: true, data: 'testando bottomSheet reativo'));
      Future.delayed(Duration(seconds: 2), () {
        bottomSheet.modify((value) => value.copyWith(show: false));
        bottomSheet.modify((value) => value.copyWith(show: true));
      });
    }

    if (withDebounce) {
      runDebounce(
        'increment',
        () => print(count.value),
        duration: Duration(seconds: 1),
      );
    }
  }
}
