import '../../../cubes.dart';

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
/// on 08/11/21
extension StringExtensions on String {
  String tr({Map<String, String>? params}) {
    return Cubes.getString(
      this,
      params: params,
    );
  }
}
