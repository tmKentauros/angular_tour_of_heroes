import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import 'hero.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [formDirectives],
)
class AppComponent {
  final title = 'Tour of Heroes';
  var hero = Hero(1, 'Windstorm');
}
