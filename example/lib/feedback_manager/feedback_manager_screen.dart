import 'package:cubes/cubes.dart';
import 'package:examplecube/feedback_manager/feedback_manager_cube.dart';
import 'package:flutter/material.dart';

class FeedbackManagerScreen extends CubeWidget<FeedbackManagerCube> {
  @override
  Widget buildView(BuildContext context, FeedbackManagerCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FeedBackManager'),
      ),
      body: CFeedBackManager(
        dialogControllers: [
          CDialogController<String>(
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
          CBottomSheetController<String>(
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
          CSnackBarController(
            observable: cube.snackBarControl,
            builder: (data, context) => SnackBar(content: Text(data)),
          ),
        ],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  child: Text('Show dialog per 3 seconds'),
                  onPressed: cube.showDialogPer3Seconds),
              ElevatedButton(
                  child: Text('Show bottomSheet per 3 seconds'),
                  onPressed: cube.showBottomSheetPer3Seconds),
              ElevatedButton(
                  child: Text('Show snackBar'), onPressed: cube.showSnackBar),
            ],
          ),
        ),
      ),
    );
  }
}
