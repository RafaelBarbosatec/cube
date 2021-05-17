import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cubes_localization.dart';

/// Delegate responsible for internationalization from json files
class CubesLocalizationDelegate
    extends LocalizationsDelegate<CubesLocalization> {
  /// primary constructor of the CubesLocalizationDelegate
  const CubesLocalizationDelegate(
    this.supportedLocations, {
    this.pathFiles = 'lang/',
  }) : assert(supportedLocations.length > 0);

  /// path where the json files are located
  final String pathFiles;

  /// List of the locations supported
  final List<Locale> supportedLocations;

  @override
  bool isSupported(Locale locale) {
    return supportedLocations
        .map((e) => e.languageCode)
        .contains(locale.languageCode);
  }

  /// Get delegates to run internationalization
  List<LocalizationsDelegate> get delegates => [
        this,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  @override
  Future<CubesLocalization> load(Locale locale) async {
    var localizations = CubesLocalization(
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
