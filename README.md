[![pub package](https://img.shields.io/pub/v/cubes.svg)](https://pub.dartlang.org/packages/cubes)

<a href="https://github.com/RafaelBarbosatec/cube">
   <img alt="Cubes" src="https://raw.githubusercontent.com/RafaelBarbosatec/cube/master/media/icon.png" height=80/>
</a>

# Cubes

Simple State Manager with dependency injection and no code generation required.

With Cubes, rebuilding only takes place where it is needed!

MVVM based architecture.

## Install
To use this plugin, add `cubes` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/cubes/install).

## Usage

* Creating Cube:

```dart

class CounterCube extends Cube {
  final count = ObservableValue<int>(value: 0);

  // To List use `ObservableList`.
  // To others objects not primitive remember call `prop.notify();` after modification to notify listeners.

    @override
    void ready() {
      // do anything when view is ready
      super.ready();
    }

    void increment() {
      count.value++;
      if (count.value == 5) {
        onAction(CubeSuccessAction(text: "count five")); // to send action to view
      }

      if (count.value == 50) {
        onAction(CubeErrorAction(text: "You are clicking too much o.O")); // to send action to view
      }

      // example apply debounce
       runDebounce(
        'increment', // identify
        ()  => print(count.value),
        duration: Duration(seconds: 1),
      );
    }
}

```

In ʻonAction` you can send `CubeSuccessAction` and `CubeErrorAction` to view. Or create your own action by creating a class and extending `CubeAction`.

- Registering Cubes and or dependencies:

```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

void main() {
  // register cube
  Cubes.registerDependency((i) => CounterCube());

  // Example register singleton Cube
  // Cubes.registerDependency((i) => CounterCube(),isSingleton: true);

  // Example register repositories or anything
  // Cubes.registerDependency((i) => SingletonRepository(i.getDependency(),isSingleton: true);
  // Cubes.registerDependency((i) => FactoryRepository(i.getDependency());

  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    ));
}

```

* Creating view with `CubeBuilder`:

```dart

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CubeBuilder<CounterCube>(
      onAction: (CounterCube cube, CubeAction action) {
        if (action is CubeSuccessAction) {
          print('CubeSuccessAction: ${action.text}');
        }
        if (action is CubeErrorAction) {
          print('CubeErrorAction: ${action.text}');
        }
      },
      builder: (BuildContext context,CounterCube cube) {
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
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}

```

 or use `CubeWidget`

```dart

class Home extends CubeWidget<CounterCube> {

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
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void onAction(BuildContext context, PokemonCube cube, CubeAction action) {
    // TODO: implement onAction
    super.onAction(context, cube, action);
  }
}

```

Cube and its dependencies are injected into CubeBuilder and CubeWidget without the need for any extra configuration.

By doing this:

```
  cube.count.build<int>((value) {
    return Text(value.toString());
  }),

```

we register by listening to the Observer `count`, and every time this variable is changed, the` View` is notified by running the code block again:

```
  return Text(value.toString());
```

This guarantees that in the whole widget tree of your screen, only the necessary is rebuilt.

## Testing

```dart

import 'package:flutter_test/flutter_test.dart';

void main() {
  CounterCube cube;
  setUp(() {
    cube = CounterCube();
  });

  tearDown(() {
    cube?.dispose();
  });
  test('initial value', () {
    expect(cube.count.value, 0);
  });

  test('increment value', () {
    cube.increment();
    expect(cube.count.value, 1);
  });

  test('increment value 3 times', () {
    cube.increment();
    cube.increment();
    cube.increment();
    expect(cube.count.value, 3);
  });
}

```

Example with asynchronous call [here](https://github.com/RafaelBarbosatec/cube/blob/master/example/test/unit/pokemon_test.dart)
Example widget test [here](https://github.com/RafaelBarbosatec/cube/blob/master/example/test/widget/cube_test.dart)

## Useful extensions

```dart

    // BuildContextExtensions

    context.goTo(Widget());
    context.goToReplacement(Widget());
    context.goToAndRemoveUntil(Widget(),RoutePredicate);

    context.mediaQuery; // MediaQuery.of(context);
    context.padding; // MediaQuery.of(context).padding;
    context.viewInsets; // MediaQuery.of(context).viewInsets;

    context.sizeScreen; // MediaQuery.of(context).size;
    context.widthScreen; // MediaQuery.of(context).size.width;
    context.heightScreen; // MediaQuery.of(context).size.height;

    context.theme;
    context.scaffold;

```

## Useful Widgets

### AnimatedListCube

This is a version of AnimatedList that simplifies its use for the Cube context.

```

  AnimatedListCube<String>(
    itemList: cube.todoList,
    itemBuilder: (context, item, animation, type) {
      return ScaleTransition(
        scale: animation,
        child: _buildItem(item),
      );
    },
  )

```

Full usage example [here](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/todo/todo_list.dart).

## Internationalization support

With Cubes you can configure internationalization in your application. in a simple way using .json files.

### Using

Create a folder named `lang` and put your files with name location. This way:

![](https://raw.githubusercontent.com/RafaelBarbosatec/cube/master/media/example-folders.png)

Add path in your `pubspec.yaml`:

```yaml

  # To add assets to your application, add an assets section, like this:
  assets:
   - lang/

```

In your `MaterialApp` you can configure the `CubesLocalizationDelegate`:


```dart

    final cubeLocation = CubesLocalizationDelegate(
      [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
    );

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'My app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: cubeLocation.delegates, // see here
        supportedLocales: cubeLocation.supportedLocations, // see here
        home: Home(),
      );
    }

```

Ready!!!  Your application already supports internationalization. Bas get the strings as follows:

```dart

  String text = Cubes.getString('welcome');

```

By default, we use [get_it](https://pub.dev/packages/get_it) to manage dependencies. if you want to use another one you can overwrite the Injector:

```dart

  class MyInjector extends Injector {
   @override
    T getDependency<T>({String dependencyName}) {
    }

    @override
    void registerDependency<T>(DependencyInjectorBuilder<T> builder, {String dependencyName, bool isSingleton = false}) {
    }

    @override
    void reset() {
    }
  }

  Cubes.instance.customInjector(MyInjector());

```

Any questions see our [example](https://github.com/RafaelBarbosatec/cube/tree/master/example).


