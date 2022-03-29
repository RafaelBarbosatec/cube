import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:examplecube/counter/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../util/robot.dart';

class CounterWidgetRobot extends Robot {
  CounterWidgetRobot(WidgetTester tester) : super(tester);

  Future setup() async {
    _setupInjections();
    final cubeLocation = CubesLocalizationDelegate(
      [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
    );
    await widgetSetup(
      CounterScreen(),
      materialAppParams: CubeRobotMaterialAppParams(
        localizationsDelegates: cubeLocation.delegates,
        supportedLocales: cubeLocation.supportedLocations,
      ),
    );
  }

  void _setupInjections() {
    Cubes.resetInjector();
    Cubes.registerFactory((injector) => CounterCube(withDebounce: false));
  }

  Finder get buttonIncrement {
    return find.byKey(CounterScreen.KEY_FLOATING_BUTTON);
  }

  void assetText() {
    final finder = find.text(Cubes.getString('description_counter'));
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
