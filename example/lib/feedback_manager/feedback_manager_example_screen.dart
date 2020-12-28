import 'package:cubes/cubes.dart';
import 'package:examplecube/feedback_manager/feedback_manager_example_cube.dart';
import 'package:flutter/material.dart';

class FeedbackManagerExampleScreen extends CubeWidget<FeedbackManagerExampleCube> {
  @override
  Widget buildView(BuildContext context, FeedbackManagerExampleCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FeedBackManager'),
      ),
      body: FeedBackManager(
        dialogControllers: [
          DialogController<String>(
            observable: cube.dialogControl,
            dismissible: false,
            builder: (data, context) => Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(data),
                ),
              ),
            ),
          ),
        ],
        bottomSheetControllers: [
          BottomSheetController<String>(
            dismissible: false,
            observable: cube.bottomSheetControl,
            builder: (data, context) => Container(
              height: 200,
              child: Center(
                child: Text(data),
              ),
            ),
          ),
        ],
        snackBarControllers: [
          SnackBarController(
            observable: cube.snackBarControl,
            builder: (data, context) => SnackBar(content: Text(data)),
          ),
        ],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton(child: Text('Show dialog per 3 seconds'), onPressed: cube.showDialogPer3Seconds),
              RaisedButton(child: Text('Show bottomSheet per 3 seconds'), onPressed: cube.showBottomSheetPer3Seconds),
              RaisedButton(child: Text('Show snackBar'), onPressed: cube.showSnackBar),
            ],
          ),
        ),
      ),
    );
  }
}
