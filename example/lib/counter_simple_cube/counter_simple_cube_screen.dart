import 'package:cubes/cubes.dart';
import 'package:examplecube/counter_simple_cube/counter_simple_cube.dart';
import 'package:flutter/material.dart';

class CounterSimpleCubeScreen extends StatefulWidget {
  const CounterSimpleCubeScreen({Key? key}) : super(key: key);

  @override
  _CounterSimpleCubeScreenState createState() =>
      _CounterSimpleCubeScreenState();
}

class _CounterSimpleCubeScreenState extends State<CounterSimpleCubeScreen> {
  late CounterSimpleCube cube;

  @override
  void initState() {
    cube = Cubes.getDependency();
    super.initState();
  }

  @override
  void dispose() {
    cube.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('counter'.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('description_counter'.tr()),
            cube.count.build<int>(
              (value) => Text(value.toString()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cube.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
