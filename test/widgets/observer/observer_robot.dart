import 'package:cubes/src/widgets/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ObserverRobot {
  final WidgetTester tester;

  ObserverRobot(this.tester);

  Future setup() async {
    await tester.pumpWidget(
      MaterialApp(
        home: CObserver(),
      ),
    );
  }
}
