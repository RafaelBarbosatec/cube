import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// Created by
///
/// ─▄▀─▄▀
/// ──▀──▀
/// █▀▀▀▀▀█▄
/// █░░░░░█─█
/// ▀▄▄▄▄▄▀▀
///
/// Rafaelbarbosatec
/// on 03/09/21

class CubeRobotMaterialAppParams {
  final ThemeData? themeData;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale>? supportedLocales;

  CubeRobotMaterialAppParams({
    this.themeData,
    this.themeMode,
    this.darkTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.locale,
  });
}

abstract class Robot {
  static const SIZE_DEVICE_DEFAULT = Size(1440, 2560);
  final WidgetTester tester;

  Robot(this.tester);

  Future<void> widgetSetup(
    Widget widget, {
    Duration? awaitAnimation,
    Size? sizeScreen,
    CubeRobotMaterialAppParams? materialAppParams,
  }) async {
    tester.binding.window.physicalSizeTestValue =
        sizeScreen ?? SIZE_DEVICE_DEFAULT;
    await tester.pumpWidget(
      MaterialApp(
        home: widget,
        theme: materialAppParams?.themeData,
        localizationsDelegates: materialAppParams?.localizationsDelegates,
        supportedLocales:
            materialAppParams?.supportedLocales ?? [Locale('en', 'US')],
        darkTheme: materialAppParams?.darkTheme,
        themeMode: materialAppParams?.themeMode,
        locale: materialAppParams?.locale,
        debugShowCheckedModeBanner: false,
      ),
    );

    await awaitForAnimations(duration: awaitAnimation);
  }

  Future<void> awaitForAnimations({Duration? duration}) async {
    try {
      await tester.pumpAndSettle(duration ?? Duration(milliseconds: 300));
    } catch (e) {
      await tester.pump(duration);
    }
  }

  Future takeSnapshot(String filename) {
    return expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('./golden_files/$filename.png'),
    );
  }
}
