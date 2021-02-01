import 'package:flutter_test/flutter_test.dart';

import 'observer_robot.dart';

void main() {
  testWidgets('', (WidgetTester tester) async {
    final robot = ObserverRobot(tester);
    await robot.setup();
  });
}
