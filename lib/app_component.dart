import 'package:angular/angular.dart';
import 'hero.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
)
class AppComponent {
  final title = 'Tour of Heroes';
  var hero = Hero(1, 'Windstorm');
}
