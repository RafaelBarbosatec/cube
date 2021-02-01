import 'package:cubes/cubes.dart';
import 'package:cubes/src/injector/getit_injector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CInjector injector;
  int _counter = 0;
  setUp(() {
    injector = GetItInjector();
  });

  tearDown(() {
    _counter = 0;
    injector.reset();
  });

  test('verify return injected factory', () {
    injector.registerDependency<String>((injector) {
      _counter++;
      return 'count: $_counter';
    });
    expect(injector.getDependency<String>(), 'count: 1');
    expect(injector.getDependency<String>(), 'count: 2');
    expect(injector.getDependency<String>(), 'count: 3');
  });

  test('verify return injected singleton', () {
    injector.registerDependency<String>(
      (injector) {
        _counter++;
        return 'count: $_counter';
      },
      isSingleton: true,
    );
    expect(injector.getDependency<String>(), 'count: 1');
    expect(injector.getDependency<String>(), 'count: 1');
    expect(injector.getDependency<String>(), 'count: 1');
  });
}
