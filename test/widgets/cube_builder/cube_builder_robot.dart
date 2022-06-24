import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ActionExample extends CubeAction {
  @override
  void execute(BuildContext context) {}
}

class CubeExample extends Cube {
  void sendAction(CubeAction action) {
    super.sendAction(action);
  }
}

class MockCubeTest extends Mock implements CubeExample {}

class CubeBuilderRobot {
  final WidgetTester tester;
  CubeExample? _cubeReturned;
  CubeAction? _actionReturnedInView;
  late CubeExample _cubeMock;
  final Map _argumentTest = {
    'cube': 'Simple State Manager with dependency injection.',
  };
  CubeBuilderRobot(this.tester);

  void _setupInjections({bool useMock = true}) {
    _cubeMock = useMock ? MockCubeTest() : CubeExample();
    Cubes.resetInjector();
    Cubes.registerSingleton(_cubeMock);
  }

  Future setup({bool useMock = true}) async {
    _setupInjections(useMock: useMock);

    await tester.pumpWidget(
      MaterialApp(
        home: CubeConsumer<CubeExample>(
          arguments: _argumentTest,
          onAction: (cube, action) {
            _actionReturnedInView = action;
          },
          builder: (context, cube) {
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
    final action = ActionExample();
    _cubeMock.sendAction(action);
    await tester.pumpAndSettle();
    expect(_actionReturnedInView, action);
  }
}
