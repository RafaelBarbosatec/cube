import 'package:flutter_test/flutter_test.dart';

import 'counter_widget_robot.dart';

void main() {
  testWidgets('Should show counter egual 0', (WidgetTester tester) async {
    final robot = CounterWidgetRobot(tester);
    await robot.setup();
    await robot.assetText();
    await robot.assetValue0();
    await robot.clickIncrement();
    await robot.clickIncrement();
    await robot.clickIncrement();
    await robot.assetValue3();
  });
}
