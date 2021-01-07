import 'package:cubes/src/localization/cubes_localization.dart';

class CStringsLocation {
  static final CStringsLocation instance = CStringsLocation._internal();

  static CubesLocalization _myLocalizations;

  static void configure(CubesLocalization location) {
    _myLocalizations = location;
  }

  CStringsLocation._internal();

  String getString(String key, {Map<String, String> params}) {
    String str = _myLocalizations.trans(key);
    params?.forEach((key, value) => str = str.replaceAll(key, value));
    return str;
  }
}
