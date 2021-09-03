import 'package:flutter_test/flutter_test.dart';

import 'counter_widget_robot.dart';

void main() {
  testWidgets('Should load Screen', (WidgetTester tester) async {
    final robot = CounterWidgetRobot(tester);
    await robot.setup();
    await robot.assetSnapshotScreen();
  });

  testWidgets('Should increment counter when click in button',
      (WidgetTester tester) async {
    final robot = CounterWidgetRobot(tester);
    await robot.setup();
    robot.assetText();
    robot.assetValue0();
    await robot.clickIncrement();
    await robot.clickIncrement();
    await robot.clickIncrement();
    robot.assetValue3();
  });
}
