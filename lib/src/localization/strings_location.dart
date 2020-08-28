import 'package:cubes/src/localization/cubes_localization.dart';

class StringsLocation {
  static final StringsLocation instance = StringsLocation._internal();

  static CubesLocalization _myLocalizations;

  static void configure(CubesLocalization location) {
    _myLocalizations = location;
  }

  StringsLocation._internal();

  String getString(String key) {
    return _myLocalizations.trans(key);
  }
}

String getString(String key) {
  return StringsLocation.instance.getString(key);
}
