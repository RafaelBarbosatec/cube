import 'cubes_localization.dart';

// ignore: one_member_abstracts
abstract class CGetterStringLocation {
  String getString(String key, {Map<String, String> params});
}

/// Responsible for helping us get the words from the locate files
class CStringsLocation implements CGetterStringLocation {
  static final CStringsLocation _instance = CStringsLocation._internal();

  factory CStringsLocation() => _instance;
  CubesLocalization _myLocalizations;

  CStringsLocation._internal();

  set cubesLocalisation(CubesLocalization localization) => _instance._myLocalizations = localization;
  CubesLocalization get cubesLocalisation => _instance._myLocalizations;

  String getString(String key, {Map<String, String> params}) {
    var str = _myLocalizations?.trans(key);
    params?.forEach((key, value) => str = str?.replaceAll(key, value));
    return str;
  }
}
