import 'dart:async';

import 'package:cubes/src/localization/cubes_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CubesLocalizationDelegate
    extends LocalizationsDelegate<CubesLocalization> {
  const CubesLocalizationDelegate(
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
  Future<CubesLocalization> load(Locale locale) async {
    CubesLocalization localizations = CubesLocalization(
      locale,
      pathFiles: pathFiles,
    );
    await localizations.load();
    print("Cubes: Load (${locale.toString()}) localization.");
    return localizations;
  }

  @override
  bool shouldReload(CubesLocalizationDelegate old) => false;
}
