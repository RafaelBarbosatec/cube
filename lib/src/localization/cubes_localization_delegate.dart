import 'dart:async';

import 'package:cubes/src/localization/cube_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CubeLocalizationsDelegate
    extends LocalizationsDelegate<CubeLocalizations> {
  const CubeLocalizationsDelegate(
    this.supportedLocations, {
    this.pathFiles = 'lang/',
  })  : assert(supportedLocations != null),
        assert(supportedLocations.length > 0);

  final String pathFiles;
  final List<Locale> supportedLocations;

  @override
  bool isSupported(Locale locale) {
    return true;
  }

  List<LocalizationsDelegate> get delegates => [
        this,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  @override
  Future<CubeLocalizations> load(Locale locale) async {
    if (!supportedLocations.contains(locale)) {
      locale = supportedLocations.first;
    }
    CubeLocalizations localizations = CubeLocalizations(
      locale,
      pathFiles: pathFiles,
    );
    await localizations.load();
    print("Cubes: Load (${locale.toString()}) localization.");
    return localizations;
  }

  @override
  bool shouldReload(CubeLocalizationsDelegate old) => false;
}
