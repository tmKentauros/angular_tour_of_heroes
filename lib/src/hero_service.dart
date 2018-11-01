import 'hero.dart';
import 'mock_heroes.dart';

import 'dart:async';

class HeroService {
  Future<List<Hero>> getAll() async => mockHeroes;
}
