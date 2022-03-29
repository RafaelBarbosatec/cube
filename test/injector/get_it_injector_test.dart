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
    injector.putFactory<String>((injector) {
      _counter++;
      return 'count: $_counter';
    });
    expect(injector.get<String>(), 'count: 1');
    expect(injector.get<String>(), 'count: 2');
    expect(injector.get<String>(), 'count: 3');
  });

  test('verify return injected singleton', () {
    _counter++;
    injector.putSingleton<String>(
      'count: $_counter',
    );
    expect(injector.get<String>(), 'count: 1');
    expect(injector.get<String>(), 'count: 1');
    expect(injector.get<String>(), 'count: 1');
  });

  test('verify return injected singleton lazy', () {
    injector.putLazySingleton<String>(
      (injector) {
        _counter++;

        return 'count: $_counter';
      },
    );
    expect(injector.get<String>(), 'count: 1');
    expect(injector.get<String>(), 'count: 1');
    expect(injector.get<String>(), 'count: 1');
  });

  test('verify return injected factory async', () {
    injector.putDependencyAsync<String>(
      (injector) async {
        await Future.delayed(Duration(seconds: 1));

        return 'value async';
      },
    );
    injector.getAsync<String>().then((value) {
      expect(value, 'value async');
    });
  });

  test('verify return injected singleton async', () async {
    injector.putDependencyAsync<String>(
      (injector) async {
        await Future.delayed(Duration(seconds: 1));
        _counter++;

        return 'count: $_counter';
      },
      type: DependencyRegisterType.singleton,
    );

    final r1 = await injector.getAsync<String>();
    final r2 = await injector.getAsync<String>();

    expect(r1, 'count: 1');
    expect(r2, 'count: 1');
  });

  test('verify return injected singleton async lazy', () async {
    injector.putDependencyAsync<String>(
      (injector) async {
        await Future.delayed(Duration(seconds: 1));
        _counter++;

        return 'count: $_counter';
      },
      type: DependencyRegisterType.lazySingleton,
    );

    final r1 = await injector.getAsync<String>();
    final r2 = await injector.getAsync<String>();

    expect(r1, 'count: 1');
    expect(r2, 'count: 1');
  });
}
