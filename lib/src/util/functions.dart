import 'package:flutter/widgets.dart';

Widget widgetCondition({@required bool condition, @required Widget match, Widget notMatch}) {
  return condition ? match : notMatch ?? SizedBox.shrink();
}
