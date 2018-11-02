import 'package:angular/angular.dart';

import 'hero.dart';
import 'hero_service.dart';

@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard_component.html',
  styleUrls: ['dashboard_component.css'],
  directives: [coreDirectives],
  providers: [ClassProvider(HeroService)],
)
class DashboardComponent implements OnInit {
  List<Hero> heroes;

  final HeroService _heroService;

  DashboardComponent(this._heroService);

  @override
  void ngOnInit() async {
    heroes = (await _heroService.getAll()).skip(1).take(4).toList();
  }
}
