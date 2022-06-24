import 'package:flutter/material.dart';

export 'navigator_action.dart';

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
/// Base to Actions

abstract class CubeAction {
  /// When the action is sent he will are executed per this method
  void execute(BuildContext context);
}
