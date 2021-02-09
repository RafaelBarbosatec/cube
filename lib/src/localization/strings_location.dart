import 'package:cubes/src/localization/cubes_localization.dart';

abstract class CGetterStringLocation {
  String getString(String key, {Map<String, String> params});
}

/// Responsible for helping us get the words from the locate files
class CStringsLocation implements CGetterStringLocation {
  static final CStringsLocation instance = CStringsLocation._internal();

  CubesLocalization _myLocalizations;

  CStringsLocation._internal();

  static void configure(CubesLocalization location) {
    instance._myLocalizations = location;
  }

  String getString(String key, {Map<String, String> params}) {
    String str = _myLocalizations?.trans(key);
    params?.forEach((key, value) => str = str?.replaceAll(key, value));
    return str;
  }
}
