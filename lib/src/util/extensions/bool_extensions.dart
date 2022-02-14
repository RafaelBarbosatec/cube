import '../functions.dart';

///
/// Created by
///
/// ─▄▀─▄▀
/// ──▀──▀
/// █▀▀▀▀▀█▄
/// █░░░░░█─█
/// ▀▄▄▄▄▄▀▀
///
/// Rafaelbarbosatec
/// on 14/02/22

extension BoolExtensions on bool {
  T? conditional<T>({
    required T match,
    T? notMatch,
  }) =>
      genericConditional(
        condition: this,
        match: match,
        notMatch: notMatch,
      );
}
