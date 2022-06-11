[![pub package](https://img.shields.io/pub/v/cubes.svg)](https://pub.dartlang.org/packages/cubes)
![](https://img.shields.io/github/workflow/status/RafaelBarbosatec/cube/unit-tests)

<a href="https://github.com/RafaelBarbosatec/cube">
   <img alt="Cubes" src="https://raw.githubusercontent.com/RafaelBarbosatec/cube/master/media/icon.png" height=80/>
</a>

# Cubes

Simple State Manager with dependency injection and no code generation required.

## About

Manage the state of your Flutter application in a simple and objective way, rebuilding the widget tree only where necessary!

`Cubes` makes use of [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) since it is a feature already available in Flutter and for its simplicity. `Cubes` doesn't rely on [RxDart](https://pub.dev/packages/rxdart).

## Install
To use this plugin, add `cubes` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/cubes/install).



## Counter Example

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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

```

## Usage

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
    void onReady(Object arguments) {
      // do anything when view is ready
      super.ready(arguments);
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

---

For those of you who don't like to depend your projects too much in a package, there are other ways to work with it:

- You can use the `CubeConsumer` widget, see this [example](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/counter/counter_screen.dart);
- To work with `StatefulWidget` you can use the mixin `CubeStateMixin<StatefulWidget,Cube>`. See this [example](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/counter/counter_screen_animation.dart);
- For a minimalist approach, you can use `SimpleCube`. See this [example](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/counter_simple_cube).

---

## Listening observable variables

You can listen to observables in two ways: using the extension `build` as mentioned earlier or using the `CObserver` widget:

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

To get the reference of a specific Cube from `CubeConsumer` or `CubeWidget`, you can use `Cubes.of<MyCube>(context)`;

## Methods: Inner Cube

### sendAction

`sendAction` is used to send any type of action or message to a view. You simply create an 'action' extending from `CubeAction`.

```dart

  class EventAction extends CubeAction {
    String eventName;
    EventAction(this.eventName);
  }

```

Then, inside your cube:

```dart

class MyCube extends Cube {

   void sendEvent(){
      // sending action
     sendAction(EventAction());
   }
}

  
```

Finally, you will receive this action in the `View` through the method:

```dart

class MyScreen extends CubeWidget<MyCube> {

  @override
  Widget buildView(BuildContext context, MyCube cube) {
    return ...;
  }
  
   @override
   void onAction(BuildContext context, MyCube cube, CubeAction action) {
     if(action is EventAction){
        // do anything
     }
     super.onAction(context, cube, data);
   }

}

```

This approach will be useful for complex animations among other features that the `View` may need to perform.

### Navigation

You can use this feature to your own navigation system. But you don't have to do anything manually, we've already done that for you. Just use the `CubeNavigation` mixin.

```dart

    class MyCube extends Cube with CubeNavigation{

       void navToAnOtherScreen(){
         navToNamed('/home');
         // You can use:
         // - navToNamed
         // - navToNamedAndRemoveUntil
         // - navToNamedReplacement
         // - navTo
         // - navToReplacement
         // - navToAndRemoveUntil
         // - navPop
       }
    }

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

Create the observable to control:

``` dart

final bottomSheetControl = CFeedBackControl(data:'test').obsValue;
final dialogControl = CFeedBackControl(data:'test').obsValue;
final snackBarControl = CFeedBackControl<String>().obsValue;
```

Now just add the widget to your tree and its settings:

``` dart

CFeedBackManager(
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
With it you can work reactively with your `TextFormField`, being able to modify and read its value, set error, enable and disable it.

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

It is exactly the same as the conventional `TextFormField` with two more fields, the `observable` and `obscureTextButtonConfiguration`.

Full usage example [here](https://github.com/RafaelBarbosatec/cube/blob/master/example/lib/text_form_field).

## Internationalization support

Please use default [flutter internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)'

## Custom dependency injection

By default, `Cubes` uses [get_it](https://pub.dev/packages/get_it) to manage dependencies. if you want to use another one, you can overwrite the Injector:

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

Example widget test using `Robot` [here](https://github.com/RafaelBarbosatec/cube/tree/master/example/test/widget/counter)

If there are still doubts, you should be able to find what you're looking for in the full [example](https://github.com/RafaelBarbosatec/cube/tree/master/example).


