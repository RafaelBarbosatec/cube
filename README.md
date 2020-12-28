[![pub package](https://img.shields.io/pub/v/cubes.svg)](https://pub.dartlang.org/packages/cubes)

<a href="https://github.com/RafaelBarbosatec/cube">
   <img alt="Cubes" src="https://raw.githubusercontent.com/RafaelBarbosatec/cube/master/media/icon.png" height=80/>
</a>

# Cubes

Simple State Manager with dependency injection and no code generation required.

With Cubes, manage the state of the application in a simple and objective way and reconstructing in your widget tree only where necessary!

MVVM based architecture.

## Install
To use this plugin, add `cubes` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/cubes/install).

## Usage

* Creating Cube:

```dart

class CounterCube extends Cube {
  final count = ObservableValue<int>(value: 0); // To List use `ObservableList`.

    @override
    void ready() {
      // do anything when view is ready
      super.ready();
    }

    void increment() {
      count.modify((value) => value + 1); // or count.update(newValue);
    }
}

```

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
      onAction: (cube, action) => print(action),
      // dispose: (cube)=> true, if you want the widget to not call `dispose` in the Cube, return false
      builder: (BuildContext context, CounterCube cube) {
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
  void onAction(BuildContext context, CounterCube cube, CubeAction action) {
    // TODO: implement onAction
    super.onAction(context, cube, action);
  }

  @override
  bool dispose(CounterCube cube) {
    // TODO: implement dispose
    return super.dispose(cube); //if you want the widget to not call `dispose` in the Cube, return false
  }
}

```

If you want to use cubes in a `StatefulWidget` you can use the mixin `CubeStateMixin<StatefulWidget,Cube>` in the state. See this [exemple](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/counter/counter_screen_animation.dart).

OBS: Cube and its dependencies are injected into `CubeBuilder` and `CubeWidget without the need for any extra configuration.

By doing this:

``` dart
  cube.count.build<int>((value) {
    return Text(value.toString());
  }),

```

we register by listening to the Observable `count`, and every time this variable is changed, the` View` is notified by running the code block again:

``` dart
  return Text(value.toString());
```

This guarantees that in the whole widget tree of your screen, only the necessary is rebuilt.

## Listening observable variables

You can listen to observables in two ways, using the extension `build` as in the example above or using the `Observer` widget:

### Extension 'build'

``` dart
  cube.count.build<int>(
     (value) => Text(value.toString()),                              // Here you build the widget and it will be rebuilt every time the variable is modified and will leave the conditions of `when`.
     animate: true,                                                  // Setting to `true`, fadeIn animation will be performed between widget changes.
     when: (last, next) => last != next,                             // You can decide when rebuild widget using previous and next value. (For a good functioning of this feature use immutable variables)
     transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,   // Here you can modify the default animation which is FadeIn.
     duration: Duration(milliseconds: 300),                          // Sets the duration of the animation.
  ),
```

### Widget Observer

``` dart
  return Observer<int>(
      observable: cube.count,
      builder: (value)=> Text(value.toString()),
      when: (last, next) => true,
      animate:true,
      transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
      duration: Duration(milliseconds: 300),
  );
```

## Provider

To get the Cube by the children of `CubeBuilder`, `CubeWidget` you can use `Cubes.of<MyCube>(context)`;

## Methods inner Cube

### onAction

In `onAction` you can send `CubeSuccessAction` and `CubeErrorAction` to view. Or create your own action by creating a class and extending `CubeAction`.

```dart
  onAction(CubeSuccessAction(text: "Login successfully"));
```

### runDebounce

This method will help you to `debounce` the execution of something.

```dart
   runDebounce(
     'increment', // identify
     ()  => print(count.value),
     duration: Duration(seconds: 1),
   );
```

### listen

Use to listen ObservableValue.

```dart
  listen(count,(value){
      // do anything
  });
```

### listenActions

Use to listen to `Action` sent to view.

```dart
  listenActions((action){
      // do anything
  });
```

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

```dart

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

## FeedBackManager

Using this widget you can reactively control your Dialogs and BottomSheets using an ObservableValue.

Creating observable to control both Dialog and BottomSheet:

``` dart

final bottomSheetControl = ObservableValue<FeedBackControl<String>(value: FeedBackControl(data:'test'));
final dialogControl = ObservableValue<FeedBackControl<String>>(value: FeedBackControl(data:'test'));

```

Now just add the widget to your tree:

``` dart

FeedbackManager(
   dialogControllers:[  // Pode adicionar quandos dialogs diferentes desejar
       DialogController(
           observable: cube.dialogControl,
           builder: (data, context) {
               return Container(height: 200, child: Center(child: Text('Dialog: $data')));
           },
       ),
   ],
   bottomSheetControllers: [  // Pode adicionar quandos bottomSheets diferentes desejar
       BottomSheetController(
           observable: cube.bottomSheetControl,
           builder: (data, context) {
               return Container(height: 200, child: Center(child: Text('BottomSheet: $data')));
           },
       ),
   ],
   child: ...
)

```

To show or hide:

``` dart

bottomSheetControl.modify((value) => value.copyWith(show: true)); // or false to hide
dialogControl.modify((value) => value.copyWith(show: true)); // or false to hide

```

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


