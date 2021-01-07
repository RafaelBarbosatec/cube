import 'package:cubes/cubes.dart';
import 'package:examplecube/counter/counter_cube.dart';
import 'package:examplecube/counter/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class CounterWidgetRobot {
  final WidgetTester tester;

  CounterWidgetRobot(this.tester) {
    _setupInjections();
  }

  void _setupInjections() {
    Cubes.resetInjector();
    Cubes.registerDependency((injector) => CounterCube(withDebounce: false));
  }

  Future setup() async {
    final cubeLocation = CubesLocalizationDelegate(
      [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: CounterScreen(),
        localizationsDelegates: cubeLocation.delegates,
        supportedLocales: cubeLocation.supportedLocations,
      ),
    );
  }

  Finder get buttonIncrement {
    return find.byKey(CounterScreen.KEY_FLOATING_BUTTON);
  }

  Future assetText() async {
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    final finder = find.text('You have pushed the button this many times:');
    expect(finder, findsOneWidget);
  }

  Future assetValue0() async {
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    final finder = find.text('0');
    expect(finder, findsOneWidget);
  }

  Future assetValue3() async {
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    final finder = find.text('3');
    expect(finder, findsOneWidget);
  }

  Future clickIncrement() async {
    await tester.tap(buttonIncrement);
  }
}
