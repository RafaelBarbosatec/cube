# Cubes examples

- [Counter (Using CubeWidget)](#counter-using-cubewidget)
- [Counter (Using CubeConsumer)](#counter-using-cubeconsumer)
- [Infinity scroll (Using CubeWidget)](#infinity-scroll-using-cubewidget)


## Counter (Using CubeWidget)

```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

void main() {

  Cubes.registerFactory((i) => CounterCube());

  runApp(MaterialApp(
      title: 'Cube Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(),
    ),
  );
}

class CounterCube extends Cube {

  final count = 0.obs;

  void increment() {
    count.modify((value) => value + 1); // or count.update(newValue);
  }

}

class CounterScreen extends CubeWidget<CounterCube> {
  @override
  Widget buildView(BuildContext context, CounterCube cube) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            SizedBox(height: 20),
            cube.count.build<int>((value) {
              return Text(value.toString());
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cube.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

```

## Counter (Using CubeConsumer)

```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

void main() {

  Cubes.registerFactory((i) => CounterCube());

  runApp(MaterialApp(
      title: 'Cube Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(),
    ),
  );
}

class CounterCube extends Cube {

  final count = 0.obs;

  void increment() {
    count.modify((value) => value + 1); // or count.update(newValue);
  }

}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubeConsumer<CounterCube>(
      builder: (BuildContext context, CounterCube cube) {
        return Scaffold(
          appBar: AppBar(
            title: Text('counter'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('You have pushed the button this many times:'),
                cube.count.build<int>(
                  (value) => Text(value.toString()),
                ),
              ],
            ),
          ),
           floatingActionButton: FloatingActionButton(
              onPressed: cube.increment,
              child: Icon(Icons.add),
            ),
        );
      },
    );
  }
}

```

## Infinity scroll (Using CubeWidget)

```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {

  Cubes.registerLazySingleton((i) => ListRepository());
  Cubes.registerFactory((i) => InfinityScrollCube(i.get());

  runApp(MaterialApp(
      title: 'Cube Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InfinityScrollScreen(),
    ),
  );
}

class ListRepository{

   late Random _random;

   ListRepository(){
        _random = Random();
   }

   Future<List<String>> getList() async{
        List<String> list = List.generate(30, (index) {
          return 'Item ${_random.nextInt(1000)}';
        });
        await Future.delayed(const Duration(seconds: 2));
        return Future.value(list);
   }
}

class InfinityScrollCube extends Cube {
  final list = <String>[].obs;
  final loading = false.obs;

  final ListRepository _repository;

  InfinityScrollCube(this._repository);

  @override
  void onReady(Object? arguments) {
    load();
  }

  void load({bool isMore = false}) async {
    if (loading.value) return;
    loading.value = true;
    List<String> newList = await _repository.getList();
    if (isMore) {
      list.addAll(newList);
    } else {
      list.update(newList);
    }
    loading.value = false;
  }
}

class InfinityScrollScreen extends CubeWidget<InfinityScrollCube> {
  const InfinityScrollScreen({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context, InfinityScrollCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfinityScroll'),
      ),
      body: Stack(
          children: [
            cube.list.build<List<String>>((value) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  if (index >= value.length - 3) {
                    cube.load(isMore: true);
                  }
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(value[index]),
                    ),
                  );
                },
              );
            }),
            cube.loading.build<bool>((value) {
              if (value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox.shrink();
              }
            })
          ]
      ),
    );
  }
}

```