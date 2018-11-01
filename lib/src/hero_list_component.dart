import 'dart:async';
import 'package:angular/angular.dart';

import 'hero.dart';
import 'hero_component.dart';
import 'hero_service.dart';

@Component(
  selector: 'my-heroes',
  styleUrls: ['hero_list_component.css'],
  templateUrl: 'hero_list_component.html',
  directives: [coreDirectives, HeroComponent],
  providers: [ClassProvider(HeroService)],
)
class HeroListComponent implements OnInit {
  final title = 'Tour of Heroes';
  final HeroService _heroService;
  List<Hero> heroes;
  Hero selected;

  HeroListComponent(this._heroService);

  void onSelect(Hero hero) => selected = hero;

  void ngOnInit() => _getHeroes();

  Future<void> _getHeroes() async {
    heroes = await _heroService.getAll();
  }
}
