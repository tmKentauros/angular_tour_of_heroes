import 'hero.dart';
import 'mock_heroes.dart';

import 'dart:async';

class HeroService {
  Future<List<Hero>> getAll() async => mockHeroes;
  Future<Hero> get(int id) async =>
      (await getAll()).firstWhere((hero) => hero.id == id);
}
