# 0.10.3

- renamed `ready` to `onReady` in `Cube`;

# 0.10.2

- improvements in  `CAnimatedList`.
- add `insert` and `insertAll` in `ObservableList`
- renamed `itemList` to `observable` in `CAnimatedList`;

# 0.10.1

- hotfix init value in `CTextFormField`.

# 0.10.0

- add `CTextFormField`.
- renamed `FeedBackManager` to `CFeedBackManager`;
- renamed `FeedBackControl` to `CFeedBackControl`;
- renamed `BottomSheetController` to `CBottomSheetController`;
- renamed `DialogController` to `CDialogController`;
- renamed `SnackBarController` to `CSnackBarController`;

# 0.9.2

- update example
- if initData is not passed, the cube's `data` is filled with `ModalRoute.of(context).settings.arguments;`

# 0.9.1

- update example and readme

# 0.9.0

- add `FeedBackManager`. Now you can control Dialogs, BottomSheets and SnackBars with Observables in reactive way

# 0.8.0

- create `CubeStateMixin` to use cube in StatefulWidget
- discontinued `CubeBuilderAnimation` and `CubeAnimationWidget`

# 0.7.0

- add method `listen` inner `Cube` to listen `ObservableValue`.
- add method `listenActions` inner `Cube` to listen `Actions`.

# 0.6.0

- Add `when` in `Observer`. Now you can decide when rebuild widget;

# 0.5.1

- Add method `update` and `modify` in `ObservableValue`;
- [BREAKING CHANGE] not modify directly the `value`, now use `update` or `modify`;
- Add `isEmpty`, `isNotEmpty`, `first` and `last` in `ObservableList`;

# 0.5.0

- Add CuberProvider. To get the Cube by the children of `CubeBuilder`, `CubeWidget` or `CubeWidgetAnimation` you can use `Cubes.of<MyCube>(context)`;

# 0.4.1

- [BREAKING CHANGE] remove `onSuccess` an `onError`. Now centers on ʻonAction(CubeAction)`.

# 0.4.0

- [BREAKING CHANGE] move `getString` to `Cubes.getString`
- [BREAKING CHANGE] move `registerDependency` to `Cubes.registerDependency`
- [BREAKING CHANGE] move `getDependency` to `Cubes.getDependency`
- [BREAKING CHANGE] remove `getCube` (use getDependency)
- [BREAKING CHANGE] remove `registerCube` (use registerDependency)
- create `Cubes.instance.customInjector(Injector)` to use if you want to overwrite the default injector (getIt).
- add test widget example of the CounterScreen.

# 0.3.5

- improvements in `CubeWidgetAnimation` [still experimental]

# 0.3.4

- improvements in `CubeWidgetAnimation`

# 0.3.3

- add `AnimatedListCube`
- add `CubeWidgetAnimation` to use animations (experimental)
- add `initState()` and `dispose()` in `CubeWidget`

# 0.3.2+1

- update README.

# 0.3.2

- add params to replace in `getString()`
- add `T getCube<T extends Cube>()`

# 0.3.1

- remove String extensions

# 0.3.0

- create `CubeWidget`

# 0.2.4

- improvements in BuildContextExtensions

# 0.2.3

- add `clear` in ObservableList.

# 0.2.2

- Improvements in `CubeBuilder` and Observer.

# 0.2.1

- Create `ObservableList`.
- Add Todo example.

# 0.2.0

- Add internationalization.

# 0.1.1

- Add getCubeIsReady and getCubesIsReady in Cube

# 0.1.0

- Add option of the singleton Cube

# 0.0.9

- Add `getCubeInMemory` in `Cube`
- Add StringExtensions
- Fix bug runDebounce

# 0.0.8

- Add animation in Observer

# 0.0.7

- Improvements in `ObservableValue`
- add `runDebounce` in `Cube`
- add extensions

# 0.0.6

- Hotfix rebuild Observer.

# 0.0.5

- Add `onAction`
- Update example.

# 0.0.4

- Improvements in ObservableValueExtensions.

# 0.0.3

- Fix removeListener.

# 0.0.2

- Improvements in CubeBuilder and Observer.

# 0.0.1

* Start Project
