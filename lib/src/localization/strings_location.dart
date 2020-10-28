import 'package:cubes/src/localization/cubes_localization.dart';

class StringsLocation {
  static final StringsLocation instance = StringsLocation._internal();

  static CubesLocalization _myLocalizations;

  static void configure(CubesLocalization location) {
    _myLocalizations = location;
  }

  StringsLocation._internal();

  String getString(String key, {Map<String, String> params}) {
    String str = _myLocalizations.trans(key);
    params?.forEach((key, value) => str = str.replaceAll(key, value));
    return str;
  }
}
