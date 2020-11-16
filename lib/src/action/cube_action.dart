abstract class CubeAction {}

class CubeSuccessAction extends CubeAction {
  final String text;

  CubeSuccessAction({this.text});

  @override
  String toString() {
    return 'CubeSuccessAction{text: $text}';
  }
}

class CubeErrorAction extends CubeAction {
  final String text;

  CubeErrorAction({this.text});

  @override
  String toString() {
    return 'CubeErrorAction{text: $text}';
  }
}
