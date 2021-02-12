import 'package:flutter_test/flutter_test.dart';

import 'cube_builder_robot.dart';

void main() {
  testWidgets('Should return cube injected', (tester) async {
    final robot = CubeBuilderRobot(tester);
    await robot.setup();
    await robot.assetCubeReturnedInBuilder();
  });
  testWidgets('Should call onReady in cube when view is ready', (tester) async {
    final robot = CubeBuilderRobot(tester);
    await robot.setup();
    await robot.assetCallOnReadyInCube();
  });
  testWidgets('Should receive an action in the view', (tester) async {
    final robot = CubeBuilderRobot(tester);
    await robot.setup(useMock: false);
    await robot.assetActionSentByCube();
  });
}
