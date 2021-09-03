import 'package:examplecube/pokemon/pokemon_cube.dart';
import 'package:examplecube/pokemon/repository/model/pokemon.dart';
import 'package:examplecube/pokemon/repository/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository repository;
  late PokemonCube cube;
  setUp(() {
    repository = MockPokemonRepository();
    cube = PokemonCube(repository);
  });

  tearDown(() {
    cube.dispose();
  });

  test('initial value', () {
    expect(cube.list.value, []);
    expect(cube.progress.value, false);
  });

  test('load pokémons', () async {
    final List<Pokemon> mockList = [
      Pokemon(),
      Pokemon(),
      Pokemon(),
      Pokemon(),
      Pokemon(),
    ];

    when(
      repository.getPokemonList(),
    ).thenAnswer((_) => Future.value(mockList));

    await cube.onReady(null);

    expect(cube.list.value, isA<List<Pokemon>>());
    expect(cube.list.value, mockList);
    expect(cube.progress.value, false);
  });
}
