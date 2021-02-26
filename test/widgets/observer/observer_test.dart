import 'package:flutter_test/flutter_test.dart';

import 'observer_robot.dart';

void main() {
  testWidgets('Should render with initial value', (tester) async {
    final robot = ObserverRobot(tester);
    await robot.setup();
    await robot.assetInitialValue();
  });

  testWidgets('Should update render with new value', (tester) async {
    final robot = ObserverRobot(tester);
    await robot.setup();
    robot.changeValueWithUpdate(25);
    await robot.assetValue(25);
  });

  // ignore: lines_longer_than_80_chars
  testWidgets('Should update render with new value using modify', (tester) async {
    final robot = ObserverRobot(tester);
    await robot.setup();
    robot.incrementValueWithModify(25);
    robot.incrementValueWithModify(5);
    await robot.assetValue(30);
  });

  testWidgets('Should note update render when not accept in WhenBuild', (tester) async {
    final robot = ObserverRobot(tester);
    await robot.setup();
    robot.whenBuild = ((lastV, newV) {
      return (newV - lastV) == 1;
    });
    robot.changeValueWithUpdate(5);
    await robot.assetValue(0);
    robot.changeValueWithUpdate(6);
    await robot.assetValue(6);
  });
}
