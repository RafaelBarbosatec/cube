import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../cube_builder/cube_builder_robot.dart';

class MockCubeTest extends Mock implements CubeExample {}

class CubeWidgetExample extends CubeWidget<CubeExample> {
  @override
  Object get arguments => CubeWidgetRobot._argumentTest;

  @override
  Widget buildView(BuildContext context, CubeExample cube) {
    CubeWidgetRobot.cubeReturned = cube;

    return Container();
  }

  @override
  void onAction(BuildContext context, CubeExample cube, CubeAction action) {
    CubeWidgetRobot.actionReturned = action;
    super.onAction(context, cube, action);
  }
}

class CubeWidgetRobot {
  final WidgetTester tester;
  late CubeExample _cubeMock;
  CubeWidgetRobot(this.tester);
  static Cube? cubeReturned;
  static CubeAction? actionReturned;
  static final Map _argumentTest = {
    'cube': 'Simple State Manager with dependency injection',
  };

  Future setup({bool useMock = true}) async {
    _setupInjections(useMock: useMock);
    await tester.pumpWidget(
      MaterialApp(
        home: CubeWidgetExample(),
      ),
    );
  }

  void _setupInjections({bool useMock = true}) {
    _cubeMock = useMock ? MockCubeTest() : CubeExample();
    if (useMock) {
      when(() => _cubeMock.onReady(any())).thenAnswer((realInvocation) {
        return Future.value();
      });
    }
    Cubes.resetInjector();
    Cubes.registerSingleton(_cubeMock);
  }

  Future assetCubeReturnedInBuilder() async {
    await tester.pumpAndSettle();
    expect(CubeWidgetRobot.cubeReturned, _cubeMock);
  }

  Future assetCallOnReadyInCube() async {
    await tester.pumpAndSettle();
    verify(()=>_cubeMock.onReady(_argumentTest)).called(1);
  }

  Future assetActionSentByCube() async {
    await tester.pumpAndSettle();
    final action = ActionExample();
    _cubeMock.sendAction(action);
    await tester.pumpAndSettle();
    expect(CubeWidgetRobot.actionReturned, action);
  }
}
