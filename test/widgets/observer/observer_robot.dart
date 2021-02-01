import 'package:cubes/cubes.dart';
import 'package:cubes/src/widgets/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ObserverRobot {
  final WidgetTester tester;
  int _valueReturnedInBuilder;
  WhenBuild<int> _whenBuild;
  ObservableValue<int> _count = ObservableValue(value: 0);

  ObserverRobot(this.tester);

  Future setup() async {
    await tester.pumpWidget(
      MaterialApp(
        home: CObserver<int>(
          observable: _count,
          when: (lastValue, newValue) {
            if (_whenBuild != null) return _whenBuild(lastValue, newValue);
            return true;
          },
          builder: (int value) {
            _valueReturnedInBuilder = value;
            return Container(
              child: Text(value.toString()),
            );
          },
        ),
      ),
    );
  }

  Future assetInitialValue() async {
    await tester.pumpAndSettle();
    expect(_valueReturnedInBuilder, 0);
  }

  void changeValueWithUpdate(int value) {
    _count.update(value);
  }

  void incrementValueWithModify(int increment) {
    _count.modify((value) => value + increment);
  }

  void registerWhenBuild(WhenBuild<int> whenBuild) {
    _whenBuild = whenBuild;
  }

  Future assetValue(int value) async {
    await tester.pumpAndSettle();
    expect(_valueReturnedInBuilder, value);
  }
}
