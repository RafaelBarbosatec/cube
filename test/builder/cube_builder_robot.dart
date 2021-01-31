import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../util/cube_test.dart';

class MockCubeTest extends Mock implements CubeTest {}

class CubeBuilderRobot {
  final WidgetTester tester;
  CubeTest _cubeReturned;
  CubeAction _actionReturnedInView;
  CubeTest _cubeMock;
  Map _argumentTest = {'cube': 'Simple State Manager with dependency injection and no code generation required.'};
  CubeBuilderRobot(this.tester);

  void _setupInjections({bool useMock = true}) {
    _cubeMock = useMock ? MockCubeTest() : CubeTest();
    Cubes.resetInjector();
    Cubes.registerDependency((injector) => _cubeMock);
  }

  Future setup({bool useMock = true}) async {
    _setupInjections(useMock: useMock);

    await tester.pumpWidget(
      MaterialApp(
        home: CubeBuilder<CubeTest>(
          arguments: _argumentTest,
          onAction: (cube, action) {
            _actionReturnedInView = action;
          },
          builder: (BuildContext context, CubeTest cube) {
            _cubeReturned = cube;
            return Container();
          },
        ),
      ),
    );
  }

  Future assetCubeReturnedInBuilder() async {
    await tester.pumpAndSettle();
    expect(_cubeReturned, _cubeMock);
  }

  Future assetCallOnReadyInCube() async {
    await tester.pumpAndSettle();
    verify(_cubeMock.onReady(_argumentTest)).called(1);
  }

  Future assetActionSentByCube() async {
    await tester.pumpAndSettle();
    final action = ActionTest();
    _cubeMock.sendAction(action);
    await tester.pumpAndSettle();
    expect(_actionReturnedInView, action);
  }
}
