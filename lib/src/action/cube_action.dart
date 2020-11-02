abstract class CubeAction {}

class CubeSuccessAction extends CubeAction {
  final String text;

  CubeSuccessAction({this.text});
}

class CubeErrorAction extends CubeAction {
  final String text;

  CubeErrorAction({this.text});
}
