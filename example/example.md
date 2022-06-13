# Cubes examples

- [Counter](#counter)


## Counter

### Creating a Cube

Cube is the class responsible for handling the business logic of your view.

To create your Cube, just make a class that extends from `Cube` as follows:

```dart

class CounterCube extends Cube {

}

```

In `Cubes`, you control elements in the view using `ObservableValues`. Creating such variables is easy:

```dart

class CounterCube extends Cube {
    final count = 0.obs;
    // final myList = <MyModel>[].obs;
    // final viewModel = ViewModel().obs;
}

```

You can modify these `ObservableValues` and then your view will react to these changes. For example:

```dart

class CounterCube extends Cube {
    final count = 0.obs;

    void increment() {
      count.modify((value) => value + 1); // or count.update(newValue);
    }
}

```

It's a common practice to query an API or do something else once the View is ready.
In `Cubes`, this is super simple to achieve. Just override the method `onReady` and your code will be called once the View is ready.

```dart

class CounterCube extends Cube {
    final count = 0.obs;

    void increment() {
      count.modify((value) => value + 1); // or count.update(newValue);
    }

    @override
    void onReady(Object? arguments) {
      // do anything when view is ready
    }
}

```

The `arguments` property is taken from the view and, if ommited, it will be taken from `ModalRoute.of(context).settings.arguments;`

### Creating a View

Creating a widget that represents a View is very simple. Make a class that extends from `CubeWidget<CubeName>` passing the `Cube` name that this view will use. For example:

```dart

class CounterScreen extends CubeWidget<CounterCube> {

}

```

Your IDE will force you to implement a mandatory method called `buildView`, just like this:

```dart

class CounterScreen extends CubeWidget<CounterCube> {

 @override
  Widget buildView(BuildContext context, CounterCube cube) {
    // TODO: implement buildView
    throw UnimplementedError();
  }

}

```

This method is similar to the 'build' method from `StatelessWidget` and `State`. There you will return your widget tree and will have access to `Cube` for listening your `ObservableValues`.

The final result looks like this:


```dart

class CounterScreen extends CubeWidget<CounterCube> {

  @override
  Widget buildView(BuildContext context, CounterCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            cube.count.build<int>((value) {
              return Text(value.toString());
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cube.increment,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

```

Note that listening to an `ObservableValue` is very simple:

```dart

   cube.count.build<int>((value) {
     return Text(value.toString());
   })

```

By listening to the `ObservableValue` `count`, every time this variable is changed the` View` is notified by running the following code again:

```dart
  return Text(value.toString());
```

This guarantees that only the necessary is rebuilt in the whole widget tree.

### Registering Cubes and dependencies

Did you notice that we never created an instance of `CounterCube`?
This is because `Cubes` works with dependency injection. So for everything to work properly, we have to register the `Cube` used and its dependencies inside `main()`.


```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

void main() {
  // Register your Cube
  Cubes.registerFactory((i) => CounterCube());

  // Example: register a singleton Cube
  // Cubes.registerSingleton(CounterCube());

  // Example: register repositories or something else
  // Cubes.registerFactory((i) => SingletonRepository(i.get());

  // Example: get any dependency
  // Cubes.get<MyDependency>();

  runApp(MaterialApp(
      title: 'Cubes Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    ));
}

```