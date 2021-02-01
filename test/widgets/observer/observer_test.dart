import 'package:flutter_test/flutter_test.dart';

import 'observer_robot.dart';

void main() {
  testWidgets('Should render with initial value', (WidgetTester tester) async {
    final robot = ObserverRobot(tester);
    await robot.setup();
    await robot.assetInitialValue();
  });

  testWidgets('Should update render with new value', (WidgetTester tester) async {
    final robot = ObserverRobot(tester);
    await robot.setup();
    robot.changeValueWithUpdate(25);
    await robot.assetValue(25);
  });

  testWidgets('Should update render with new value using modify', (WidgetTester tester) async {
    final robot = ObserverRobot(tester);
    await robot.setup();
    robot.incrementValueWithModify(25);
    robot.incrementValueWithModify(5);
    await robot.assetValue(30);
  });

  testWidgets('Should note update render when not accept in WhenBuild', (WidgetTester tester) async {
    final robot = ObserverRobot(tester);
    await robot.setup();
    robot.registerWhenBuild((lastV, newV) {
      return (newV - lastV) == 1;
    });
    robot.changeValueWithUpdate(5);
    await robot.assetValue(0);
    robot.changeValueWithUpdate(6);
    await robot.assetValue(6);
  });
}
