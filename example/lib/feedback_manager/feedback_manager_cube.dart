import 'package:cubes/cubes.dart';

class FeedbackManagerCube extends Cube {
  final dialogControl = CFeedBackControl<String>().obsValue;
  final bottomSheetControl = CFeedBackControl<String>().obsValue;
  final snackBarControl = CFeedBackControl<String>().obsValue;

  void showDialogPer3Seconds() async {
    if (dialogControl.value.show) return;
    dialogControl.modify((value) => value.copyWith(show: true, data: 'Dialog Example\n\nawait 3 seconds'));
    await Future.delayed(Duration(seconds: 3));
    dialogControl.modify((value) => value.copyWith(show: false));
  }

  void showBottomSheetPer3Seconds() async {
    if (bottomSheetControl.value.show) return;
    bottomSheetControl.modify((value) => value.copyWith(show: true, data: 'BottomSheet Example\n\nawait 3 seconds'));
    await Future.delayed(Duration(seconds: 3));
    bottomSheetControl.modify((value) => value.copyWith(show: false));
  }

  void showSnackBar() {
    snackBarControl.modify((value) => value.copyWith(show: true, data: 'SnackBar Example'));
  }
}
