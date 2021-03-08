import 'package:flutter/widgets.dart';

/// Method util uses to return anything for conditional.
T genericCondition<T>({
  @required bool condition,
  @required T match,
  T notMatch,
}) {
  return condition ? match : notMatch;
}
