import 'package:flutter_test/flutter_test.dart';

import 'cube_widget_robot.dart';

void main() {
  testWidgets('Should return cube injected', (WidgetTester tester) async {
    final robot = CubeWidgetRobot(tester);
    await robot.setup();
    await robot.assetCubeReturnedInBuilder();
  });

  testWidgets('Should call onReady in cube', (WidgetTester tester) async {
    final robot = CubeWidgetRobot(tester);
    await robot.setup();
    await robot.assetCallOnReadyInCube();
  });

  testWidgets('Should receive an action in the view', (WidgetTester tester) async {
    final robot = CubeWidgetRobot(tester);
    await robot.setup(useMock: false);
    await robot.assetActionSentByCube();
  });
}
