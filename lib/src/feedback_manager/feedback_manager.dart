import 'package:cubes/src/feedback_manager/bottom_sheet_mixin.dart';
import 'package:cubes/src/feedback_manager/dialog_feedback_mixin.dart';
import 'package:flutter/material.dart';

export 'package:cubes/src/feedback_manager/bottom_sheet_mixin.dart';
export 'package:cubes/src/feedback_manager/dialog_feedback_mixin.dart';

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

class FeedbackManager extends StatefulWidget {
  final Widget child;

  final List<BottomSheetController> bottomSheetControllers;
  final List<DialogController> dialogControllers;
  const FeedbackManager({Key key, @required this.child, this.bottomSheetControllers, this.dialogControllers})
      : super(key: key);
  @override
  _FeedbackManagerState createState() => _FeedbackManagerState();
}

class _FeedbackManagerState extends State<FeedbackManager> with DialogFeedBackMixin, BottomSheetFeedBackMixin {
  @override
  void initState() {
    confBottomSheetFeedBack(widget.bottomSheetControllers);
    confDialogFeedBack(widget.dialogControllers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
