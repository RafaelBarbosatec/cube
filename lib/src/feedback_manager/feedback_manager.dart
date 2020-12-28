import 'package:cubes/src/feedback_manager/bottom_sheet_feedback_mixin.dart';
import 'package:cubes/src/feedback_manager/dialog_feedback_mixin.dart';
import 'package:cubes/src/feedback_manager/snackbar_feedback_mixin.dart';
import 'package:flutter/material.dart';

export 'package:cubes/src/feedback_manager/bottom_sheet_feedback_mixin.dart';
export 'package:cubes/src/feedback_manager/dialog_feedback_mixin.dart';
export 'package:cubes/src/feedback_manager/snackbar_feedback_mixin.dart';

typedef Widget WidgetByDataBuilder<T>(T data, BuildContext context);

class FeedBackControl<T> {
  final bool show;
  final T data;

  FeedBackControl({this.show = false, this.data});

  FeedBackControl<T> copyWith({bool show, T data}) {
    return FeedBackControl(
      show: show ?? this.show,
      data: data ?? this.data,
    );
  }
}

class FeedBackManager extends StatefulWidget {
  final Widget child;

  final List<BottomSheetController> bottomSheetControllers;
  final List<DialogController> dialogControllers;
  final List<SnackBarController> snackBarControllers;
  const FeedBackManager({
    Key key,
    @required this.child,
    this.bottomSheetControllers,
    this.dialogControllers,
    this.snackBarControllers,
  }) : super(key: key);
  @override
  _FeedBackManagerState createState() => _FeedBackManagerState();
}

class _FeedBackManagerState extends State<FeedBackManager>
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
