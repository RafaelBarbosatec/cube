import 'package:cubes/src/localization/cubes_localization.dart';

abstract class CGetterStringLocation {
  String getString(String key, {Map<String, String> params});
}

class CStringsLocation implements CGetterStringLocation {
  static final CStringsLocation instance = CStringsLocation._internal();

  CubesLocalization _myLocalizations;

  CStringsLocation._internal();

  void configure(CubesLocalization location) {
    _myLocalizations = location;
  }

  String getString(String key, {Map<String, String> params}) {
    String str = _myLocalizations.trans(key);
    params?.forEach((key, value) => str = str.replaceAll(key, value));
    return str;
  }
}
