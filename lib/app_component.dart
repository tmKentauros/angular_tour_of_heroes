import 'package:angular/angular.dart';

import 'src/hero_list_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [HeroListComponent],
)
class AppComponent {
  final title = 'Tour of Heroes';
}
