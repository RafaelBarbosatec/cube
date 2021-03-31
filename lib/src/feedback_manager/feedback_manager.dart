import 'package:flutter/material.dart';

import 'bottom_sheet_feedback_mixin.dart';
import 'dialog_feedback_mixin.dart';
import 'snackbar_feedback_mixin.dart';

export 'package:cubes/src/feedback_manager/bottom_sheet_feedback_mixin.dart';
export 'package:cubes/src/feedback_manager/dialog_feedback_mixin.dart';
export 'package:cubes/src/feedback_manager/snackbar_feedback_mixin.dart';

typedef WidgetByDataBuilder<T> = Widget Function(T data, BuildContext context);

/// class used to control feedbacks
class CFeedBackControl<T> {
  final bool show;
  final T? data;

  /// Constructor of the CFeedBackControl
  CFeedBackControl({this.show = false, this.data});

  CFeedBackControl<T> copyWith({bool? show, T? data}) {
    return CFeedBackControl(
      show: show ?? this.show,
      data: data ?? this.data,
    );
  }
}

/// Widget that allows us to control Dialog, BottomSheet and SnackBars
/// using ObservableValue
class CFeedBackManager extends StatefulWidget {
  final Widget child;

  final List<CBottomSheetController>? bottomSheetControllers;
  final List<CDialogController>? dialogControllers;
  final List<CSnackBarController>? snackBarControllers;
  const CFeedBackManager({
    Key? key,
    required this.child,
    this.bottomSheetControllers,
    this.dialogControllers,
    this.snackBarControllers,
  }) : super(key: key);
  @override
  _CFeedBackManagerState createState() => _CFeedBackManagerState();
}

class _CFeedBackManagerState extends State<CFeedBackManager>
    with DialogFeedBackMixin, BottomSheetFeedBackMixin, SnackBarFeedBackMixin {
  @override
  void initState() {
    confBottomSheetFeedBack(widget.bottomSheetControllers);
    confDialogFeedBack(widget.dialogControllers);
    confSnackBarFeedBack(widget.snackBarControllers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
