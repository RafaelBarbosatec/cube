import 'package:cubes/cubes.dart';
import 'package:examplecube/counter_singleton/counter_singleton_widget.dart';
import 'package:flutter/material.dart';

class ScreenCounterSingleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getString('singleton')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: CounterSingletonWidget()),
                Expanded(child: CounterSingletonWidget()),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: CounterSingletonWidget()),
                Expanded(child: CounterSingletonWidget()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
