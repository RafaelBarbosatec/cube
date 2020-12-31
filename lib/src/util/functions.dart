import 'package:flutter/widgets.dart';

Widget widgetCondition({@required bool condition, @required Widget match, Widget notMatch}) {
  return condition ? match : notMatch ?? SizedBox.shrink();
}

T genericCondition<T>({@required bool condition, @required T match, T notMatch}) {
  return condition ? match : notMatch;
}
