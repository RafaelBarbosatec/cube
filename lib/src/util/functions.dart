import 'package:flutter/widgets.dart';

T genericCondition<T>({@required bool condition, @required T match, T notMatch}) {
  return condition ? match : notMatch;
}
