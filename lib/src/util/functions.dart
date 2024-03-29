import '../../cubes.dart';

/// Method util uses to return anything for conditional.
T? genericConditional<T>({
  required bool condition,
  required T match,
  T? notMatch,
}) {
  return condition ? match : notMatch;
}

T inject<T extends Object>({String? dependencyName}) {
  return Cubes.get<T>(dependencyName: dependencyName);
}
