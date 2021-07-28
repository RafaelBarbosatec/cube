import 'package:cubes/cubes.dart';
import 'package:cubes/src/injector/get_it_injector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CInjector injector;
  var _counter = 0;
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

  test('verify return injected singleton not lazy', () {
    injector.registerDependency<String>(
      (injector) {
        _counter++;

        return 'count: $_counter';
      },
      isSingleton: true,
      isSingletonLazy: false,
    );
    expect(injector.getDependency<String>(), 'count: 1');
    expect(injector.getDependency<String>(), 'count: 1');
    expect(injector.getDependency<String>(), 'count: 1');
  });

  test('verify return injected factory async', () {
    injector.registerDependencyAsync<String>(
      (injector) async {
        await Future.delayed(Duration(seconds: 1));

        return 'value async';
      },
    );
    injector.getDependencyAsync<String>().then((value) {
      expect(value, 'value async');
    });
  });

  test('verify return injected singleton async', () async {
    injector.registerDependencyAsync<String>(
      (injector) async {
        await Future.delayed(Duration(seconds: 1));
        _counter++;

        return 'count: $_counter';
      },
      isSingleton: true,
    );

    final r1 = await injector.getDependencyAsync<String>();
    final r2 = await injector.getDependencyAsync<String>();

    expect(r1, 'count: 1');
    expect(r2, 'count: 1');
  });

  test('verify return injected singleton async not lazy', () async {
    injector.registerDependencyAsync<String>(
      (injector) async {
        await Future.delayed(Duration(seconds: 1));
        _counter++;

        return 'count: $_counter';
      },
      isSingleton: true,
      isSingletonLazy: false,
    );

    final r1 = await injector.getDependencyAsync<String>();
    final r2 = await injector.getDependencyAsync<String>();

    expect(r1, 'count: 1');
    expect(r2, 'count: 1');
  });
}
