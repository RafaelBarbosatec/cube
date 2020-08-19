import 'package:examplecube/pokemon/pokemon_cube.dart';
import 'package:examplecube/pokemon/repository/model/pokemon.dart';
import 'package:examplecube/pokemon/repository/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  MockPokemonRepository repository;
  PokemonCube cube;
  setUp(() {
    repository = MockPokemonRepository();
    cube = PokemonCube(repository);
  });

  tearDown(() {
    cube?.dispose();
  });
  test('initial value', () {
    expect(cube.list.value, []);
    expect(cube.progress.value, false);
  });

  test('load pokémons', () async {
    List<Pokemon> mockList = [
      Pokemon(),
      Pokemon(),
      Pokemon(),
      Pokemon(),
      Pokemon()
    ];

    when(
      repository.getPokemonList(page: 0),
    ).thenAnswer((_) => Future.value(mockList));

    await cube.ready();

    expectLater(cube.list.value, mockList);
  });
}
