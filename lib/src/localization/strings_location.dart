import 'dart:ui';

import 'cubes_localization.dart';

/// Interface used to get locate and get string from json file
abstract class CGetterStringLocation {
  /// Get current locate loaded
  Locale currentLocale();

  /// Get String from json file
  String getString(String key, {Map<String, String> params});
}

/// Responsible for helping us get the words from the locate files
class CStringsLocation implements CGetterStringLocation {
  static final CStringsLocation _instance = CStringsLocation._internal();

  /// Factory to get instance singleton of the CStringsLocation
  factory CStringsLocation() => _instance;

  /// Instance of the CubesLocalization
  CubesLocalization cubesLocalisation;

  CStringsLocation._internal();

  String getString(String key, {Map<String, String> params}) {
    var str = cubesLocalisation?.trans(key);
    params?.forEach((key, value) => str = str?.replaceAll(key, value));
    return str;
  }

  @override
  Locale currentLocale() {
    return cubesLocalisation?.locale;
  }
}
