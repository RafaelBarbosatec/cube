import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:examplecube/counter/counter_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../util/robot.dart';

class CounterWidgetRobot extends Robot {
  CounterWidgetRobot(WidgetTester tester) : super(tester);

  Future setup() async {
    _setupInjections();

    await widgetSetup(
      CounterScreen(),
    );
  }

  void _setupInjections() {
    Cubes.resetInjector();
    Cubes.registerFactory((i) => CounterCube(withDebounce: false));
  }

  Finder get buttonIncrement {
    return find.byKey(CounterScreen.KEY_FLOATING_BUTTON);
  }

  void assetText() {
    final finder = find.text('You have pushed the button this many times:');
    expect(finder, findsOneWidget);
  }

  void assetValue0() {
    final finder = find.text('0');
    expect(finder, findsOneWidget);
  }

  void assetValue3() {
    final finder = find.text('3');
    expect(finder, findsOneWidget);
  }

  Future clickIncrement() async {
    await tester.tap(buttonIncrement);
    await awaitForAnimations();
  }

  Future assetSnapshotScreen() {
    return takeSnapshot('counterScreen');
  }
}
