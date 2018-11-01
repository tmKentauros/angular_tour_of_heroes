import 'package:angular/angular.dart';

import 'src/hero.dart';

import 'src/hero_component.dart';
import 'src/hero_service.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [coreDirectives, HeroComponent],
  providers: [ClassProvider(HeroService)],
)
class AppComponent implements OnInit {
  final title = 'Tour of Heroes';
  List<Hero> heroes;
  Hero selected;

  final HeroService _heroService;

  AppComponent(this._heroService);

  void onSelect(Hero hero) => selected = hero;

  void ngOnInit() => _getHeroes();

  void _getHeroes() {
    heroes = _heroService.getAll();
  }
}
