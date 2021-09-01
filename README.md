[![pub package](https://img.shields.io/pub/v/cubes.svg)](https://pub.dartlang.org/packages/cubes)
![](https://img.shields.io/github/workflow/status/RafaelBarbosatec/cube/unit-tests)

<a href="https://github.com/RafaelBarbosatec/cube">
   <img alt="Cubes" src="https://raw.githubusercontent.com/RafaelBarbosatec/cube/master/media/icon.png" height=80/>
</a>

# Cubes

Simple State Manager with dependency injection and no code generation required.

With Cubes, manage the state of the application in a simple and objective way and reconstructing in your widget tree only where necessary!

No uses [RxDart](https://pub.dev/packages/rxdart), `Cubes` uses [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) because it is a feature already available in Flutter and for its simplicity.

## Install
To use this plugin, add `cubes` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/cubes/install).



## Counter Example

```dart

```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

void main() {
 
  Cubes.registerDependency((i) => CounterCube());

  runApp(MaterialApp(
      title: 'Cube Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CounterScreen(),
    ),
  );
}

class CounterCube extends Cube {

  final count = 0.obsValue;

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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

```

## Usage

### Creating a Cube

Cube is the classe responsible to center business logic of the your view. 

For create your cube, just create a class and extends of `Cube` like this:

```dart

class CounterCube extends Cube {
   
}

```

In `Cubes` you controll elements in the view using `ObservableValues`. To create once is easy:

```dart

class CounterCube extends Cube {
    final count = 0.obsValue;
    // final myList = <MyModel>[].obsValue;
    // final viewModel = ViewMidel().obsValue;
}

```

Ready, now we can modify these `ObservableValues` and your view will react to these changes. For example:

```dart

class CounterCube extends Cube {
    final count = 0.obsValue;
    
    void increment() {
      count.modify((value) => value + 1); // or count.update(newValue);
    }
}

```

It's normal to want to do a query in an API or do something else once the View is ready. 
In `Cubes` it is super simple to do this. You can do overrride of the methos `onReady`, this is called when your View is a ready. 

```dart

class CounterCube extends Cube {
    final count = 0.obsValue;
    
    void increment() {
      count.modify((value) => value + 1); // or count.update(newValue);
    }
    
    @override
    void onReady(Object arguments) {
      // do anything when view is ready
      super.ready(arguments);
    }
}

```

The `arguments` variable we get is passed by the view, and if we don't pass this variable it gets from `ModalRoute.of(context).settings.arguments;`

### Creating a View

We widget that represents the View is very simple. just create a class and extends of `CubeWidget<CubeName>` passing the `Cube` name that this view will uses. For example:

```dart

class CounterScreen extends CubeWidget<CounterCube> {
   
}

```

Your IDE will force you to implement a mandatory method called `buildView`. getting like this:

```dart

class CounterScreen extends CubeWidget<CounterCube> {

 @override
  Widget buildView(BuildContext context, CounterCube cube) {
    // TODO: implement buildView
    throw UnimplementedError();
  }
   
}

```

It is similar to the 'build' method already known to you from `StatelessWidget` and `State`. Where you will return your widget tree and will already have access to `Cube` to listen to the `ObservableValues`.
The end result is this:


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

Note that listening to the `ObservableValue` was very simple. Simply:

```dart

   cube.count.build<int>((value) {
     return Text(value.toString());
   })

```

This way we listening to the `ObservableValue` `count`, and every time this variable is changed, the` View` is notified by running the code block again:

``` dart
  return Text(value.toString());
```

This guarantees that in the whole widget tree of your screen, only the necessary is rebuilt.

### Registering Cubes and dependencies

Did you notice that we never created an instance of `CounterCube`?
This is because `Cubes` works with dependency injection. So for everything to work properly we have to register the `Cube` used and its dependencies, if any.


```dart

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

void main() {
  // register cube
  Cubes.registerDependency((i) => CounterCube());

  // Example register singleton Cube
  // Cubes.registerDependency(
  //    (i) => CounterCube(),
  //    type: DependencyRegisterType.singleton,
  // );

  // Example register repositories or anything
  // Cubes.registerDependency((i) => SingletonRepository(i.getDependency());

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

---

For those of you who don't like to attach a package to your project too much, there are other ways to work the View part. Look:

- You can use `CubeBuilder` widget, see this [example](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/counter/counter_screen.dart);
- To work with `StatefulWidget` you can use the mixin `CubeStateMixin<StatefulWidget,Cube>` see this [example](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/counter/counter_screen_animation.dart);
- If you want to use it in a more minimalist way you can use the `SimpleCube`, see this [example](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/counter_simple_cube).

---

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

### Widget CObserver

``` dart
  return CObserver<int>(
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

`onAction` is used to send any type of action or message to a view. You simply create an 'action' extending from `CubeAction`.

```dart

  class NavigationAction extends CubeAction {
      final String route;
      NavigationAction({this.route});
  }

```

In your cube

```dart

class MyCube extends Cube {

   void navToGome(){
      // sending action
     onAction(NavigationAction(route: "/home"));
   }
}

  
```dart

you will receive this action in the `View` through the method:

```dart

class MyScreen extends CubeWidget<MyCube> {

  @override
  Widget buildView(BuildContext context, MyCube cube) {
    return ...;
  }
  
   @override
   void onAction(BuildContext context, MyCube cube, CubeAction action) {
     if(action is NavigationAction) Navigator.pushNamed(context, (action as NavigationAction).route);
     super.onAction(context, cube, data);
   }

}

```

this will be useful for navigation, to start some more complex animation, among other needs that `View` has to perform.

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

## Useful Widgets

### CAnimatedList

This is a version of AnimatedList that simplifies its use for the Cube context.

```dart

  CAnimatedList<String>(
    observable: cube.todoList,
    itemBuilder: (context, item, animation, type) {
      return ScaleTransition(
        scale: animation,
        child: _buildItem(item),
      );
    },
  )

```

Full usage example [here](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/todo/todo_list.dart).

### CFeedBackManager

Use this widget if you want to reactively control your `Dialog`, `BottomSheet` and `SnackBar` using an ObservableValue.

Creating observable to control:

``` dart

final bottomSheetControl = CFeedBackControl(data:'test').obsValue;
final dialogControl = CFeedBackControl(data:'test').obsValue;
final snackBarControl = CFeedBackControl<String>().obsValue;
```

Now just add the widget to your tree and settings:

``` dart

FeedBackManager(
   dialogControllers:[  // You can add as many different dialogs as you like
       CDialogController<String>(
           observable: cube.dialogControl,
           // dismissible: bool,
           // barrierColor: Color,
           // routeSettings: RouteSettings,
           // useRootNavigator: bool,
           // useSafeArea: bool,
           builder: (data, context) {
               return Container(height: 200, child: Center(child: Text('Dialog: $data')));
           },
       ),
   ],
   bottomSheetControllers: [  // You can add as many different BottomSheets as you like
       CBottomSheetController<String>(
           observable: cube.bottomSheetControl,
           // dismissible: bool,
           // useRootNavigator: bool,
           // routeSettings: RouteSettings,
           // barrierColor: Color,
           // backgroundColor: Color,
           // elevation: double,
           // shape: ShapeBorder,
           // clipBehavior: Clip,
           // enableDrag: bool,
           // isScrollControlled: bool,
           // useSafeArea: bool,
           builder: (data, context) {
               return Container(height: 200, child: Center(child: Text('BottomSheet: $data')));
           },
       ),
   ],
   snackBarControllers: [
       CSnackBarController<String>(
           observable: cube.snackBarControl,
           builder: (data, context) {
               return SnackBar(content: Text(data));
           },
       ),
   ],
   child: ...
)

```

To show or hide:

``` dart

    bottomSheetControl.show(); // or hide();
    dialogControl.show(); // or hide();
    snackBarControl.show(data: 'Success');

```

Full usage example [here](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/feedback_manager).

### CTextFormField

Widget created to use `TextFormField` with` ObservableValue`.
With it you can work reactively with your `TextFormField`. Being able to modify and read its value, set error, enable and disable.

``` dart

 /// code in Cube

 final textFieldControl = CTextFormFieldControl(text: '').obsValue;

 //  final text = textFieldControl.text; // get text
 //  textFieldControl.text = 'New text'; // change text
 //  textFieldControl.error = 'error example'; // set error
 //  textFieldControl.enable = true; // enable or disable
 //  textFieldControl.enableObscureText = true; // enable or disable obscureText

 // code in Widget

 CTextFormField(
   observable: cube.textFieldControl,
   obscureTextButtonConfiguration: CObscureTextButtonConfiguration(  // use to configure the hide and show content icon in case of obscureText = true.
     align: CObscureTextAlign.right,
     iconHide: Icon(Icons.visibility_off_outlined),
     iconShow: Icon(Icons.visibility_outlined),
   ),
   decoration: InputDecoration(hintText: 'Type something'),
   // ... All other TextFormField attributes
 ),

```

It is exactly the same as the conventional `TextFormField` with two more fields, the` observable` and `obscureTextButtonConfiguration`.

Full usage example [here](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/text_form_field).

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

## Custom dependency injection

By default, we use [get_it](https://pub.dev/packages/get_it) to manage dependencies. if you want to use another one you can overwrite the Injector:

```dart

  class MyInjector extends CInjector {
   @override
    T getDependency<T>({String dependencyName}) {
      // your implementation
    }

    @override
    void registerDependency<T>(DependencyInjectorBuilder<T> builder, {String dependencyName, bool isSingleton = false}) {
      // your implementation
    }

    @override
    void reset() {
      // your implementation
    }
  }

  Cubes().injector = MyInjector();

```

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
    context.showSnackBar(SnackBar());
    context.arguments;
    context.getCube<MyCube>(); // get Cube from provided

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

Example widget test [here](https://github.com/RafaelBarbosatec/cube/tree/master/example/test/widget/counter)

Any questions see our [example](https://github.com/RafaelBarbosatec/cube/tree/master/example).


