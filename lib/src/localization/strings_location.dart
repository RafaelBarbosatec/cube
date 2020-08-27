import 'package:cubes/src/localization/cubes_localization.dart';

class StringsLocation {
  static final StringsLocation _singleton = StringsLocation._internal();

  static CubesLocalization _myLocalizations;

  static void configure(CubesLocalization location) {
    _myLocalizations = location;
  }

  factory StringsLocation() {
    return _singleton;
  }

  StringsLocation._internal();

  String getString(String key) {
    return _myLocalizations.trans(key);
  }
}

String getString(String key) {
  return StringsLocation().getString(key);
}
