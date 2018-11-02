**対象読者**

-   本当にプログラミング初心者
-   AngularDartをいじったことが無い。

**事前準備**

-   AngularDartのインストールが終わっている。
-   gitがインストールされている。

## とりあえず起動！

1.  以下のコマンドでリポジトリをクローンする！

```cmd
    git clone
```

1.  以下のコマンドで実行する！

    ```cmd
        pub get
        webdev serve
    ```

    `pub get`は初回のみでOK！
    また`webdev serve`は、一度実行したらソースファイルを編集して保存するたびに自動で再実行？される！
    だからこれ以降は基本的にはコマンドをいじる必要が無いよ！

2.  <http://localhost:8080/>をブラウザで開いて実行結果を確認する！
    ＜スクショ＞
    こんなのが表示されたらOK！

**ちょっと脇道**
`lib/app_component.dart`の`{{name}}`は、`AppComponent`クラス内の`name`の値に置換される！
`name`の値を変更したら、ブラウザに反映されるか確認してみよう！

ついてこれているかい？

ネクストッ

## Heroを表示！

1.  `lib/app_component.dart`を編集してとりあえず表示！

    -   `@Component`アノテーション
        -   `'`→`'''`に変更し、複数行の文字列に変更する！
        -   `{{name}}`の行を削除し、`{{title}}`と`{{hero}}`を追加する！
    -   `AppComponent`クラス
        -   `title`と`hero`を追加！
        -   `name`を削除！

    ```dart
        import 'package:angular/angular.dart';

        @Component(
          selector: 'my-app',
          template: '''
            <h1>{{title}}</h1>
            <h2>{{hero}}</h2>
          ''',
        )
        class AppComponent {
          final title = 'Tour of Heroes';
          var hero = 'Windstorm';
        }
    ```

    ブラウザを更新して確認！
    ＜スクショ＞

    ネクストッ

2.  Heroクラスを作って表示！

    -   新しいファイル`lib/hero.dart`を作る！

        -   Heroは`id`と`name`を持つぞ！

        ```dart
            class Hero {
              final int id;
              String name;

              Hero(this.id, this.name);
            }
        ```

    -   `lib/app_component.dart`を編集！
        -   WindstormをHeroクラス化！
        -   Windstormの`id`と`name`を表示！

    ```dart
        import 'package:angular/angular.dart';

        // ↓インポート文を追加！
        import 'hero.dart';

        @Component(
          selector: 'my-app',
          // ↓heroクラスのプロパティを表示するように変更！
          template: '''
            <h1>{{title}}</h1>
            <h2>{{hero.name}}</h2>
            <div><label>id: </label>{{hero.id}}</div>
            <div><label>name: </label>{{hero.name}}</div>
          ''',
        )
        class AppComponent {
          final title = 'Tour of Heroes';
          // ↓Heroクラスを使うように変更！
          var hero = Hero(1, 'Windstorm');
        }
    ```

    ブラウザを更新して確認！
    &lt;スクショ>

    ネクストッ

## templateを別ファイルに！

そろそろHTMLをDart内の文字列として記述するのが面倒になってきた頃合いでしょう。
実はtemplateは別のHTMLファイルで定義することが可能です！Cool！

1.  `app_component.html`を作成！

    ```html
        <h1>{{title}}</h1>
        <h2>{{hero.name}}</h2>
        <div><label>id: </label>{{hero.id}}</div>
        <div><label>name: </label>{{hero.name}}</div>
    ```

2.  `app_component.dart`を修正！
    ```dart
        @Component(
          selector: 'my-app',
          // template -> templateUrl に変更！
          templateUrl: 'app_component.html',
        )
    ```

ブラウザを更新して確認！
同じように表示されたらOK！

ネクストッ

## Heroを編集できるように！

1.  `pubspec.yaml`を編集してパッケージを追加！

    ```yaml
        dependencies:
          angular: ^5.0.0
          # ↓追加！
          angular_forms: ^2.0.0
    ```

2.  パッケージを更新！

    1.  コマンドライン上で`Ctrl + C`！`webdev serve`を中止！
    2.  `pub get`コマンドでパッケージを取得！
    3.  `wevdev serve`コマンドで再開！

3.  `app_component.dart`を修正！

    ```dart
        import 'package:angular/angular.dart';

        // ↓angular_formsをインポート！
        import 'package:angular_forms/angular_forms.dart';

        import 'hero.dart';

        @Component(
          selector: 'my-app',
          templateUrl: 'app_component.html',
          // ↓追加！
          directives: [formDirectives],
        )
    ```

    **direcitivesについて**
    template内で使用するディレクティブは、すべてここに追加する必要があるよ！
    なので、ここではangular_formsのディレクティブである`fromDirectives`を追加している！

4.  `app_component.html`を修正！

    ```html
        <h1>{{title}}</h1>
        <h2>{{hero.name}}</h2>
        <div><label>id:</label>{{hero.id}}</div>
        <!-- ↓nameを表示する部分を修正！ -->
        <div>
            <label>name:</label>
            <input [(ngModel)]="hero.name" placeholder="name">
        </div>
    ```

    `[(ngModel)]`は、テキストボックス`<input>`と`AppComponent`の`hero.name`を双方向に紐付けるための構文！これによりテキストボックスの値が`<h2>`要素の`hero.name`に反映されるよ！

    ブラウザを更新して確認！
    <Gif>

    ネクストッ

## Heroリストを表示！

1.  ちょっとリファクタリング！

    -   `lib/hero.dart`を`lib/src/hero.dart`へ移動！
    -   `app_component.dart`を修正！

        ```dart
            import 'package:angular_forms/angular_forms.dart';
            // ↓パスを変更！
            import 'src/hero.dart';
        ```

    ブラウザを更新して確認！
    同じように表示されたらOK！

    ネクストッ

2.  Heroリストのモック`src/mock_heroes.dart`を作る！

    ```dart
        import 'hero.dart';

        final mockHeroes = <Hero>[
            Hero(11, 'Mr. Nice'),
            Hero(12, 'Narco'),
            Hero(13, 'Bombasto'),
            Hero(14, 'Celeritas'),
            Hero(15, 'Magneta'),
            Hero(16, 'RubberMan'),
            Hero(17, 'Dynama'),
            Hero(18, 'Dr IQ'),
            Hero(19, 'Magma'),
            Hero(20, 'Tornado')
        ];
    ```

    将来的にはWebサービスからHeroリストを取得するけど、一旦仮で作っておくよ！

3.  `lib/app_component.dart`を修正！
4.  `lib/app_component.html`を修正！
    **`*ngFor`について**
    -   `*`は`<li>`要素が[マスターテンプレート]であることを明示するものらしい！
    -   `ngFor`は、`<li>`要素内の要素を繰り返すために使うよ！
    -   ここでは、`heroes`（`mockHeroes`）の10人のHeroを１人づつ`hero`に取り出して、なくなるまで繰り返す！

ブラウザを更新して確認！
＜スクショ＞

ネクストッ

## Heroリストの見た目を変更！

これらのスタイルはAppComponentにのみ適用され、外側のHTMLには影響しない！

ブラウザを更新して確認！
＜スクショ＞

ネクストッ

## クリックで詳細を表示！

1.  `lib/app_component.html`を修正！

    **ngIfについて**
    `ngIf`も`ngFor`と似たようなもので、条件に一致したときだけその要素を表示するよ！
    `*`をつけるのも`ngFor`と同じ！

    **(click)について**
    `(click)`は`<li>`要素をクリックしたときに、定義したAppComponentのメソッドを呼び出すぞ！
    ここでは`onSelect()`だね！

    **===について**
    `===`演算子は、左右のオブジェクトが同じだったらTrue、違ったらFalseになるよ！
    ここでは、取り出した`hero`が選択したHero（`selected`）と同じだったら、`<li>`要素にCSSクラス`selected`を適用するという動作になる！

2.  `lib/app_component.dart`を修正！

    -   onSelect()を実装！

    ブラウザを更新して確認！
    ＜gif＞

    **=>について**
    `=>`は１行で関数定義の糖衣構文！下の２つは同じ動作になるよ！

    ```dart
        void onSelect(Hero hero) => selected = hero;
    ```

    ```dart
        void onSelect(Hero hero) {
          selected = hero;
        }
    ```

    気になったら試してみよう！

ネクストッ

## Heroをコンポーネント化！

1.  `src/hero_component.dart`を作る！

    **@Inputについて**
    他のコンポーネントから値を紐付けるには、`@Input`プロパティを追加する！

2.  `src/hero_component.html`を作る！

3.  `app_component.dart`を修正する！

    -   fromDirectiveはHeroComponentでしか使わないので、削除！

4.  `app_component.html`を修正する！

ブラウザを更新して確認！
同じように表示されたらOK！

ネクストッ

## Heroをサービス化！

1.  `src/hero_service.dart`を作る！
2.  HeroServiceを使うように`app_component.dart`を修正！

ブラウザを更新して確認！
同じように表示されたらOK！

ネクストッ

## HeroServiceを非同期化！

将来的には、`getAll()`でサーバーからデータを取得する！通信中に他の処理を待たせないように、処理を非同期化しよう！

1.  `hero_service.dart`を修正する！
2.  `app_component.dart`を修正する！

ブラウザを更新して確認！
同じように表示されたらOK！

**あえて遅延させてみる**

今はサーバーでなく`mockHeroes`を渡しているだけなので非同期化する前と動作はほぼ同じ！
非同期になっていることを確かめたかったら、以下のように`getAll()`を修正してみよう！

```dart
    Future<List<Hero>> getAll() async {
      return Future.delayed(Duration(seconds: 2), () => mockHeroes);
    }
```

ブラウザを更新してタイトルが表示されてから、2秒後にリストが表示されるはず！

気になる人は試してみてください！

ネクストッ

## HeroListをコンポーネント化！

これから他にも色んな機能を追加したいのですが、今のAppComponentはHeroListが占有しているので、これ以上追加したらごちゃごちゃしてしまいます。
そこで、現状のAppComponentをHeroListComponentにリネームして新しいAppComponentを作成しましょう！

1.  `src/hero_list_component.dart`を作成！

    -   `app_component.dart`の内容をコピペ！
    -   `app_component` ->`hero_list_component`に名前を修正！

    ```dart
    import 'dart:async';
    import 'package:angular/angular.dart';

    import 'hero.dart';
    import 'hero_component.dart';
    import 'hero_service.dart';

    @Component(
      selector: 'my-heroes',
      // ↓修正！
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

      // ↓修正！
      HeroListComponent(this._heroService);

      void onSelect(Hero hero) => selected = hero;

      void ngOnInit() => _getHeroes();

      Future<void> _getHeroes() async {
        heroes = await _heroService.getAll();
      }
    }
    ```

2.  `src/hero_list_component.html`を作成！

    -   `app_component.html`のうち、Heroに関係する部分（タイトル以外）をコピペ！

    ```html
    <my-hero [hero]="selected"></my-hero>

    <h2>Heroes</h2>
    <ul class="heroes">
        <!-- heroes内の要素数分繰り返す！ -->
        <li *ngFor="let hero of heroes" [class.selected]="hero === selected" (click)="onSelect(hero)">
            <!-- heroを表示する！ -->
            <span class="badge">{{hero.id}}</span> {{hero.name}}
        </li>
    </ul>
    ```

3.  `src/hero_list_component.css`を作成！

    -   `app_component.css`の内容を全部コピペ！

4.  HeroListComponentを使うように`app_component.dart`を修正！

    -   HeroListComponentに移動したコードは削除！

    ```dart
    import 'package:angular/angular.dart';

    // ↓追加！
    import 'src/hero_list_component.dart';

    @Component(
      selector: 'my-app',
      styleUrls: ['app_component.css'],
      templateUrl: 'app_component.html',
      // ↓変更！
      directives: [HeroListComponent],
    )
    class AppComponent {
      final title = 'Tour of Heroes';
    }
    ```

5.  HeroListComponentを使うように`app_component.html`を修正！

    -   HeroListComponentに移動したコードは削除！

    ```html
    <h1>{{title}}</h1>
    <!-- ↓追加！ -->
    <my-heroes></my-heroes>
    ```

ブラウザを更新して確認！
同じように表示されたらOK！

ネクストッ

## ボタンクリックでリストを表示！

テンプレートに`ngIf`を追加する方法も考えられますが、ここではルーターを活用して実装しましょう！

1.  `pubspec.yaml`を編集してパッケージを追加！

    ```yaml
        dependencies:
          angular: ^5.0.0
          angular_forms: ^2.0.0
          # ↓追加！
          angular_router: ^2.0.0-alpha+19
    ```

2.  `Ctrl + C`->`pub get`->`wevdev serve`ルーティーンでパッケージを更新！

3.  `web/main.dart`を修正してルーターを有効化！

    ```dart
    import 'package:angular/angular.dart';
    // ↓追加！
    import 'package:angular_router/angular_router.dart';

    import 'package:angular_app/app_component.template.dart' as ng;
    // ↓追加！
    import 'main.template.dart' as self;

    // ↓追加！
    @GenerateInjector(
      routerProvidersHash,
    )
    final InjectorFactory injector = self.injector$Injector;

    void main() {
        // ↓ルーターを使うように変更！
      runApp(ng.AppComponentNgFactory, createInjector: injector);
    }
    ```

    ここらへんは正直よく分からない！
    助けて！！←

4.  ルートのパスを定義する`route_paths.dart`を作成！

    -   今回は<http://localhost:8080/#heroes>でHeroリストを表示するべく次のように設定！

    ```dart
    import 'package:angular_router/angular_router.dart';

    class RoutePaths {
      // ↓パス（http://localhost:8080/#heroes）を定義
      static final heroes = RoutePath(path: 'heroes');
    }
    ```

5.  ルートを定義する`src/routes.dart`を作成！

    ```dart
    import 'package:angular_router/angular_router.dart';

    import 'route_paths.dart';
    import 'hero_list_component.template.dart' as hero_list_template;

    export 'route_paths.dart';

    class Routes {
      static final heroes = RouteDefinition(
        routePath: RoutePaths.heroes,
        // ↓おまじない？
        component: hero_list_template.HeroListComponentNgFactory,
      );

      // ↓将来複数のルートを追加しそうなので、全てのルートを取得する関数を定義しておく。
      static final all = <RouteDefinition>[
        heroes,
      ];
    }
    ```

6.  `app_component.dart`を修正！

    ```dart
    import 'package:angular/angular.dart';
    // ↓追加！
    import 'package:angular_router/angular_router.dart';

    // ↓HeroListComponentではなく、ルーターを使うように変更！
    import 'src/routes.dart';

    @Component(
      selector: 'my-app',
      styleUrls: ['app_component.css'],
      templateUrl: 'app_component.html',
      // ↓ルーターを使うように変更！
      directives: [routerDirectives],
      // ↓ここで設定したクラスのみテンプレート内で使用できる！
      exports: [RoutePaths, Routes],
    )
    ```

7.  `app_component.html`を修正！

    ```html
    <h1>{{title}}</h1>
    <!-- ↓/localhost:8080/#heroesへのリンクを設置 -->
    <nav>
        <a [routerLink]="RoutePaths.heroes.toUrl()" [routerLinkActive]="'active'">Heroes</a>
    </nav>
    <!-- ↓<router-outlet>を設置した所にルート毎のコンポーネントが表示される！ -->
    <router-outlet [routes]="Routes.all"></router-outlet>
    ```

ブラウザを更新！
Heroesボタンをクリックでリストが表示されて、URLが変わったらOK！
＜Gif＞

ネクストッ

## ダッシュボードを追加！

1.  `src/dashboard_component.dart`を作成！

    ```dart
    import 'package:angular/angular.dart';

    @Component(
      selector: 'my-dashboard',
      templateUrl: 'dashboard_component.html',
    )
    class DashboardComponent {}
    ```

2.  `src/dashboard_component.html`を作成！

    ```html
    <h3>Dashboard</h3>
    ```

3.  パスを`src/route_paths.dart`に定義！

    ```dart
    class RoutePaths {
      static final heroes = RoutePath(path: 'heroes');
      // ↓追加！
      static final dashboard = RoutePath(path: 'dashboard');
    }
    ```

4.  ルートを`src/routes.dart`に定義！

    ```dart
    import 'hero_list_component.template.dart' as hero_list_template;
    // ↓追加！
    import 'dashboard_component.template.dart' as dashboard_template;

    export 'route_paths.dart';

    class Routes {
      static final heroes = RouteDefinition(
        routePath: RoutePaths.heroes,
        component: hero_list_template.HeroListComponentNgFactory,
      );

      // ↓追加！
      static final dashboard = RouteDefinition(
        routePath: RoutePaths.dashboard,
        component: dashboard_template.DashboardComponentNgFactory,
      );

      static final all = <RouteDefinition>[
        heroes,
        // ↓追加！
        dashboard,
      ];
    }
    ```

ブラウザで<http://localhost:8080/#dashboard>にアクセス！
Dashboardと表示されればOK！
＜スクショ＞

ネクストッ

## 初期画面をダッシュボードにする！

現状、<http://localhost:8080>はAppComponentのみ表示される画面ですが、自動で<http://localhost:8080/#dashboard>へ飛ぶように設定してみましょう！（これをリダイレクトといいます。）

1.  `src/routes.dart`でリダイレクト先を定義！

    ```dart
    class Routes {
      static final heroes = RouteDefinition(
        routePath: RoutePaths.heroes,
        component: hero_list_template.HeroListComponentNgFactory,
      );

      static final dashboard = RouteDefinition(
        routePath: RoutePaths.dashboard,
        component: dashboard_template.DashboardComponentNgFactory,
      );

      // ↓リダイレクトの定義を追加！
      static final redirect = RouteDefinition.redirect(
        path: '',
        redirectTo: RoutePaths.dashboard.toUrl(),
      );

      static final all = <RouteDefinition>[
        heroes,
        dashboard,
        // ↓追加！
        redirect,
      ];
    }
    ```

ブラウザで<http://localhost:8080>にアクセス！
勝手に<http://localhost:8080/#dashboard>へ飛べばされればOK！

ネクストッ

## ダッシュボードを拡充！

ダッシュボードがさみしいのでいじりましょう！

-   タッシュボードを表示するボタンを追加！
-   ダッシュボードにトップHeroの名前を表示！

1.  `app_component.html`を修正してボタンを追加！

    ```html
    <h1>{{title}}</h1>
    <nav>
        <!-- ↓追加！ -->
        <a [routerLink]="RoutePaths.dashboard.toUrl()" [routerLinkActive]="'active'">Dashboard</a>
        <a [routerLink]="RoutePaths.heroes.toUrl()" [routerLinkActive]="'active'">Heroes</a>
    </nav>
    <router-outlet [routes]="Routes.all"></router-outlet>
    ```

2.  'src/dashboard_component.dart'を修正！

    ```dart
    import 'package:angular/angular.dart';

    // ↓追加！
    import 'hero.dart';
    import 'hero_service.dart';

    @Component(
      selector: 'my-dashboard',
      templateUrl: 'dashboard_component.html',
      // ↓CSSを追加！
      styleUrls: ['dashboard_component.css'],
      // ↓テンプレートで使いたいので追加！
      directives: [coreDirectives],
      // ↓HeroServiceを使いたいので追加！
      providers: [ClassProvider(HeroService)],
    )
    // ↓クラスの詳細を追加！
    class DashboardComponent implements OnInit {
      List<Hero> heroes;

      final HeroService _heroService;

      DashboardComponent(this._heroService);

      @override
      void ngOnInit() async {
        // ↓HeroListの2,3,4,5番目のHeroを取得
        heroes = (await _heroService.getAll()).skip(1).take(4).toList();
      }
    }
    ```

3.  'src/dashboard_component.html'を修正！

    -   4つのHero名を■で縦1×横4に並べた画面をつくる。
    -   `grid grid-pad`→Hero名をパッド（■）で格子状に並べるための定義。
    -   `col-1-4`→1×4で横並びにするための定義。
    -   `module`→パッド内のスタイルの定義。
    -   `hero`→Hero名（文字列）のスタイルの定義。

    ```html
    <h3>Top Heroes</h3>
    <div class="grid grid-pad">
        <div *ngFor="let hero of heroes" class="col-1-4">
            <div class="module hero">
                <h4>{{hero.name}}</h4>
            </div>
        </div>
    </div>
    ```

4.  'src/dashboard_component.css'を作成！

    ```css
    [class*='col-'] {
      float: left;
      padding-right: 20px;
      padding-bottom: 20px;
    }
    [class*='col-']:last-of-type {
      padding-right: 0;
    }
    a {
      text-decoration: none;
    }
    *, *:after, *:before {
      -webkit-box-sizing: border-box;
      -moz-box-sizing: border-box;
      box-sizing: border-box;
    }
    h3 {
      text-align: center; margin-bottom: 0;
    }
    h4 {
      position: relative;
    }
    .grid {
      margin: 0;
    }
    .col-1-4 {
      width: 25%;
    }
    .module {
      padding: 20px;
      text-align: center;
      color: #eee;
      max-height: 120px;
      min-width: 120px;
      background-color: #607D8B;
      border-radius: 2px;
    }
    .module:hover {
      background-color: #EEE;
      cursor: pointer;
      color: #607d8b;
    }
    .grid-pad {
      padding: 10px 0;
    }
    .grid-pad > [class*='col-']:last-of-type {
      padding-right: 20px;
    }
    @media (max-width: 600px) {
      .module {
        font-size: 10px;
        max-height: 75px; }
    }
    @media (max-width: 1024px) {
      .grid {
        margin: 0;
      }
      .module {
        min-width: 60px;
      }
    }
    ```

ブラウザを更新！
Hero名が4つ表示されていればOK！
＜スクショ＞

ネクストッ

## Hero毎の詳細画面を追加！

1.  パスを`src/route_paths.dart`に定義！

    ```dart
    import 'package:angular_router/angular_router.dart';

    // ↓Hero毎のIDが反映される！
    const idParam = 'id';

    class RoutePaths {
      static final heroes = RoutePath(path: 'heroes');
      static final dashboard = RoutePath(path: 'dashboard');
      // ↓パスを追加！
      static final hero = RoutePath(path: '${heroes.path}/:$idParam');
    }
    ```

2.  ルートを`src/routes.dart`に定義！

    ```dart
    // ···

    // ↓追加！
    import 'hero_component.template.dart' as hero_template;

    export 'route_paths.dart';

    class Routes {

      // ···

      // ↓Heroのルートを定義
      static final hero = RouteDefinition(
        routePath: RoutePaths.hero,
        component: hero_template.HeroComponentNgFactory,
      );

      static final all = <RouteDefinition>[
        heroes,
        dashboard,
        redirect,
        // ↓追加！
        hero,
      ];
    }
    ```

3.  `src/hero_service.dart`にIDからHeroを取得する関数を実装！

    ```dart
    class HeroService {
      Future<List<Hero>> getAll() async => mockHeroes;
      // ↓追加！
      // ↓全てのHeroの中から、IDが最初に一致したHeroを返す！
      Future<Hero> get(int id) async =>
          (await getAll()).firstWhere((hero) => hero.id == id);
    }
    ```

4.  `src/hero_component.dart`を修正！

    -   HeroComonentはルーターからHeroのIDを取得して特定のHeroを表示するようにしたい！
    -   あと戻るボタンを追加したい！

    ```dart
    import 'package:angular/angular.dart';
    import 'package:angular_forms/angular_forms.dart';
    // ↓ルーターを使うので追加！
    import 'package:angular_router/angular_router.dart';

    import 'hero.dart';
    // ↓上で実装したget関数を使いたいので追加！
    import 'hero_service.dart';
    // ↓ルーターを使うので追加！
    import 'route_paths.dart';

    @Component(
      selector: 'my-hero',
      templateUrl: 'hero_component.html',
      directives: [coreDirectives, formDirectives],
      // ↓HeroServiceとLocationを使いたいので追加！
      providers: [ClassProvider(HeroService), ClassProvider(Location)],
    )
    class HeroComponent implements OnActivate {
      // 親コンポーネントからは取得しないので、`@Input()`は削除！
      Hero hero;

      // ↓
      final HeroService _heroService;
      final Location _location;

      HeroComponent(this._heroService, this._location);

      // ↓Heroルートに入ったときにHeroを取得する！
      @override
      void onActivate(_, RouterState current) async {
        final id = getId(current.parameters);
        if (id != null) hero = await (_heroService.get(id));
      }

      // ↓idが見つかったら文字列からIntに変換して返す！
      // ↓そうでなければ、nullを返す！
      int getId(Map<String, String> parameters) {
        final id = parameters[idParam];
        return id == null ? null : int.tryParse(id);
      }

      // ↓戻るボタンのための関数`実装！
      void goBack() => _location.back();
    }
    ```

5.  `src/hero_component.html`で戻るボタンを追加！

    ```html
    <div *ngIf="hero != null">
        <h2>{{hero.name}}</h2>
        <div>
            <label>id: </label>{{hero.id}}</div>
        <div>
            <label>name: </label>
            <input [(ngModel)]="hero.name" placeholder="name" />
        </div>
        <!-- 戻るボタンを追加！ -->
        <button (click)="goBack()">Back</button>
    </div>
    ```

ブラウザで<http://localhost:8080/#heroes/11>にアクセス！
Mr. Niceの詳細画面が表示されればOK！
＜スクショ＞

一応、戻るボタンが効くことも確認しておこう！

ネクストッ

## Hero毎の画面へのリンクを各コンポーネントに追加！

1.  `src/dashboard_component.dart`にid毎のURLを生成する関数を追加！

    ```dart
    import 'package:angular/angular.dart';
    // ↓ルーターを使うので追加！
    import 'package:angular_router/angular_router.dart';

    // …

    @Component(
      // …
      styleUrls: ['dashboard_component.css'],
      // ↓ルーターを使うので追加！
      directives: [coreDirectives, routerDirectives],
      providers: [ClassProvider(HeroService)],
    )
    class DashboardComponent implements OnInit {

      // …

      // ↓Hero毎のURLを取得する関数を実装！
      String heroUrl(int id) => RoutePaths.hero.toUrl(parameters: {idParam: '$id'});
    }
    ```

2.  `src/dashboard_component.html`にリンクを追加！

    ```html
    <h3>Top Heroes</h3>
    <div class="grid grid-pad">
        <!-- ↓div要素からa要素（パイパーリンク）に変更！ -->
        <!-- ↓そしてリンク先を追加！ -->
        <a *ngFor="let hero of heroes" class="col-1-4" [routerLink]="heroUrl(hero.id)">
            <div class="module hero">
                <h4>{{hero.name}}</h4>
            </div>
        </a>
    </div>
    ```

    ブラウザを更新！
    ダッシュボードのHero名をクリックして、Heroの詳細が表示されればOK！

3.  `src/hero_list_component.dart`を修正！

    ```dart
    // …

    // ↓ルーターを使うので追加！
    import 'package:angular_router/angular_router.dart';

    // …

    // ↓ルーターを使うので追加！
    import 'route_paths.dart';

    @Component(

      // …

      // ↓HeroComponentは使わないので削除！
      directives: [coreDirectives],
      providers: [ClassProvider(HeroService)],
      // ↓テンプレートでパイプ処理を書くので追加！
      pipes: [commonPipes],
    )
    class HeroListComponent implements OnInit {
      final HeroService _heroService;
      // ↓追加！
      final Router _router;
      List<Hero> heroes;
      Hero selected;

      // ↓ルーターを追加！
      HeroListComponent(this._heroService, this._router);

      // …

      // ↓Heroの詳細を表示するボタンのための関数を実装！
      Future<NavigationResult> gotoDetail() =>
          _router.navigate(_heroUrl(selected.id));

      String _heroUrl(int id) =>
          RoutePaths.hero.toUrl(parameters: {idParam: '$id'});
    }
    ```

4.  `src/hero_list_component.html`を修正！

    ```html
    <!-- 選択したHeroの詳細は表示しないので削除！ -->
    <h2>Heroes</h2>
    <ul class="heroes">
        <li *ngFor="let hero of heroes" [class.selected]="hero === selected" (click)="onSelect(hero)">
            <span class="badge">{{hero.id}}</span> {{hero.name}}
        </li>
        <!-- ↓選択したHeroの概要と詳細へのリンクを表示！ -->
        <div *ngIf="selected != null">
            <!-- ↓パイプ処理でselected.nameを全て大文字に変換！ -->
            <h2>
                {{selected.name | uppercase}} is my hero
            </h2>
            <button (click)="gotoDetail()">View Details</button>
        </div>
    </ul>
    ```

5.  `src/hero_component.css`を作成！

    ```css
    label {
      display: inline-block;
      width: 3em;
      margin: .5em 0;
      color: #607D8B;
      font-weight: bold;
    }
    input {
      height: 2em;
      font-size: 1em;
      padding-left: .4em;
    }
    button {
      margin-top: 20px;
      font-family: Arial;
      background-color: #eee;
      border: none;
      padding: 5px 10px;
      border-radius: 4px;
      cursor: pointer; cursor: hand;
    }
    button:hover {
      background-color: #cfd8dc;
    }
    button:disabled {
      background-color: #eee;
      color: #ccc;
      cursor: auto;
    }
    ```


6.  `src/hero_component.dart`を修正！

    ```dart
    @Component(
      selector: 'my-hero',
      templateUrl: 'hero_component.html',
      // ↓追加！
      styleUrls: ['hero_component.css'],
      directives: [coreDirectives, formDirectives],
      providers: [ClassProvider(HeroService), ClassProvider(Location)],
    )
    ```

7.  `app_component.css`を修正！

    ```css
    h1 {
      font-size: 1.2em;
      color: #999;
      margin-bottom: 0;
    }
    h2 {
      font-size: 2em;
      margin-top: 0;
      padding-top: 0;
    }
    nav a {
      padding: 5px 10px;
      text-decoration: none;
      margin-top: 10px;
      display: inline-block;
      background-color: #eee;
      border-radius: 4px;
    }
    nav a:visited, a:link {
      color: #607D8B;
    }
    nav a:hover {
      color: #039be5;
      background-color: #CFD8DC;
    }
    nav a.active {
      color: #039be5;
    }
    ```

ブラウザを更新！

ダッシュボードとHeroリストの両方からHeroの詳細画面へ行けたらOK！
＜スクショ＞

ネクストッ

## Heroのデータをサーバーから取得する！

1.  `pubspec.yaml`にパッケージを追加！

    ```yaml
    dependencies:
      angular: ^5.0.0
      angular_forms: ^2.0.0
      angular_router: ^2.0.0-alpha+19
      # ↓2つ追加！
      http: ^0.11.0
      stream_transform: ^0.0.6
    ```

2.  `in_memory_data_service.dart`を作成！

    ```dart
    import 'dart:async';
    import 'dart:convert';
    import 'dart:math';

    import 'package:http/http.dart';
    import 'package:http/testing.dart';

    import 'src/hero.dart';

    class InMemoryDataService extends MockClient {
      static final _initialHeroes = [
        {'id': 11, 'name': 'Mr. Nice'},
        {'id': 12, 'name': 'Narco'},
        {'id': 13, 'name': 'Bombasto'},
        {'id': 14, 'name': 'Celeritas'},
        {'id': 15, 'name': 'Magneta'},
        {'id': 16, 'name': 'RubberMan'},
        {'id': 17, 'name': 'Dynama'},
        {'id': 18, 'name': 'Dr IQ'},
        {'id': 19, 'name': 'Magma'},
        {'id': 20, 'name': 'Tornado'}
      ];
      static List<Hero> _heroesDb;
      static int _nextId;
      static Future<Response> _handler(Request request) async {
        if (_heroesDb == null) resetDb();
        var data;
        switch (request.method) {
          case 'GET':
            final id = int.tryParse(request.url.pathSegments.last);
            if (id != null) {
              data = _heroesDb
                  .firstWhere((hero) => hero.id == id); // throws if no match
            } else {
              String prefix = request.url.queryParameters['name'] ?? '';
              final regExp = RegExp(prefix, caseSensitive: false);
              data = _heroesDb.where((hero) => hero.name.contains(regExp)).toList();
            }
            break;
          case 'POST':
            var name = json.decode(request.body)['name'];
            var newHero = Hero(_nextId++, name);
            _heroesDb.add(newHero);
            data = newHero;
            break;
          case 'PUT':
            var heroChanges = Hero.fromJson(json.decode(request.body));
            var targetHero = _heroesDb.firstWhere((h) => h.id == heroChanges.id);
            targetHero.name = heroChanges.name;
            data = targetHero;
            break;
          case 'DELETE':
            var id = int.parse(request.url.pathSegments.last);
            _heroesDb.removeWhere((hero) => hero.id == id);
            // No data, so leave it as null.
            break;
          default:
            throw 'Unimplemented HTTP method ${request.method}';
        }
        return Response(json.encode({'data': data}), 200,
            headers: {'content-type': 'application/json'});
      }

      static resetDb() {
        _heroesDb = _initialHeroes.map((json) => Hero.fromJson(json)).toList();
        _nextId = _heroesDb.map((hero) => hero.id).fold(0, max) + 1;
      }

      static String lookUpName(int id) =>
          _heroesDb.firstWhere((hero) => hero.id == id, orElse: null)?.name;
      InMemoryDataService() : super(_handler);
    }
    ```

    この`in_memory_data_service.dart`も所詮モックなので、詳細の説明はここでは省きます！

    （説明できるとは言ってない←）

3.  `web/main.dart`を修正！

    ```dart
    import 'package:angular/angular.dart';
    import 'package:angular_router/angular_router.dart';
    // ↓追加！
    import 'package:http/http.dart';

    import 'package:angular_app/app_component.template.dart' as ng;
    // ↓追加！
    import 'package:angular_app/in_memory_data_service.dart';

    import 'main.template.dart' as self;

    // ↓[]のつけ忘れに注意！
    @GenerateInjector([
      routerProvidersHash,
      // ↓追加！コンポーネントに追加するのと同じ意味！
      ClassProvider(Client, useClass: InMemoryDataService),
    ])
    ```

4.  `src/hero.dart`を修正！

    ```dart
    class Hero {
      final int id;
      String name;

      Hero(this.id, this.name);

      // ↓json形式でHttp通信するので、jsonとクラスを相互に変換する関数を実装！
      factory Hero.fromJson(Map<String, dynamic> hero) =>
          Hero(_toInt(hero['id']), hero['name']);
      Map toJson() => {'id': id, 'name': name};
    }

    int _toInt(id) => id is int ? id : int.parse(id);
    ```

5.  `src/hero_service.dart`を修正！

    ```dart
    // ↓インポート文を修正！
    import 'dart:async';
    import 'dart:convert';

    import 'package:http/http.dart';

    import 'hero.dart';

    // ↓getAll関数でサーバーからデータを取得するように変更！
    class HeroService {
      static const _heroesUrl = 'api/heroes';

      final Client _http;

      HeroService(this._http);

      Future<List<Hero>> getAll() async {
        try {
          final response = await _http.get(_heroesUrl);
          final heroes = (_extractData(response) as List)
              .map((json) => Hero.fromJson(json))
              .toList();
          return heroes;
        } catch (e) {
          throw _handleError(e);
        }
      }

      // ↓get関数は修正しなくても動作する。
      // ↓が、毎回Heroリストを取得するのは無駄なので、
      // ↓idが合致するHeroのデータだけ取得するように修正！
      Future<Hero> get(int id) async {
        try {
          final response = await _http.get('$_heroesUrl/$id');
          return Hero.fromJson(_extractData(response));
        } catch (e) {
          throw _handleError(e);
        }
      }

      dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

      Exception _handleError(dynamic e) {
        print(e); // for demo purposes only
        return Exception('Server error; cause: $e');
      }
    }
    ```

6.  `mock_heroes.dart`は不要になったので削除！

ブラウザを更新！
さっきと同じようにHeroリストが表示されたらOK！

ネクストッ

## Hero名の変更を保存する保存ボタンを追加！

1.  `src/hero_service.dart`を修正！

    ```dart
    // …

    class HeroService {
      static const _heroesUrl = 'api/heroes';
      // ↓追加！
      static final _headers = {'Content-Type': 'application/json'};

      // …

      // ↓Heroの変更を反映する関数を実装！
      Future<Hero> update(Hero hero) async {
        try {
          final url = '$_heroesUrl/${hero.id}';
          final response =
              await _http.put(url, headers: _headers, body: json.encode(hero));
          return Hero.fromJson(_extractData(response));
        } catch (e) {
          throw _handleError(e);
        }
      }

    // …
    ```

2.  `src/hero_component.dart`を修正！

    ```dart
    // ↓追加！
    import 'dart:async';

    // …

    class HeroComponent implements OnActivate {

        // …

        // ↓保存ボタン用の関数を実装！
        Future<void> save() async {
          await _heroService.update(hero);
          goBack();
        }
    }
    ```


    }

    ```

3.  `src/hero_component.html`を修正！

    ```html
    <div *ngIf="hero != null">

        <!-- … -->

        <!-- ↓保存ボタンを追加！ -->
        <button (click)="save()">Save</button>
        <button (click)="goBack()">Back</button>
    </div>
    ```

ブラウザを更新！
詳細画面からHero名を変更して保存ボタンを押してみよう！

変更が反映されて、ダッシュボードとHeroリストを行き来しても変更した内容が維持されていればOK！

※モックサーバーなのでブラウザを更新すると元に戻るよ！

ネクストッ

## 新しいHeroを作成するボタンを追加！

1.  `src/hero_service.dart`を修正！

    ```dart
    class HeroService {

      // …

      // ↓文字列からHeroを作成して保存する関数を実装！
      Future<Hero> create(String name) async {
        try {
          final response = await _http.post(_heroesUrl,
              headers: _headers, body: json.encode({'name': name}));
          return Hero.fromJson(_extractData(response));
        } catch (e) {
          throw _handleError(e);
        }
      }

      // …
    }
    ```

2.  `src/hero_list_component.dart`を修正！

    ```dart
    class HeroListComponent implements OnInit {

      // …

      // ↓追加ボタン用の関数を実装！
      Future<void> add(String name) async {
        name = name.trim();
        if (name.isEmpty) return null;
        heroes.add(await _heroService.create(name));
        selected = null;
      }
    }
    ```

3.  `src/hero_list_component.html`を修正！

    ```html
    <!-- ↓Hero名の入力フォームと追加ボタンを実装！ -->
    <div>
        <label>Hero name:</label> <input #heroName />
        <button (click)="add(heroName.value); heroName.value=''">
            Add
        </button>
    </div>
    <h2>Heroes</h2>
    <!-- … -->
    ```

ブラウザを更新！
Heroリスト画面からHero名を入力して追加ボタンを押してみよう！

変更が反映されて、ダッシュボードとHeroリストを行き来しても変更した内容が維持されていればOK！

※モックサーバーなのでブラウザを更新すると元に戻るよ！

ネクストッ

## Heroの削除ボタンを追加！

1.  `src/hero_service.dart`を修正！

    ```dart
    class HeroService {

      // …

      // ↓IDからHeroを特定して削除する関数を実装！
      Future<void> delete(int id) async {
        try {
          final url = '$_heroesUrl/$id';
          await _http.delete(url, headers: _headers);
        } catch (e) {
          throw _handleError(e);
        }
      }

      // …
    }
    ```

2.  `src/hero_list_component.dart`を修正！

    ```dart
    class HeroListComponent implements OnInit {

      // …

      // ↓削除ボタン用の関数を実装！
      Future<void> delete(Hero hero) async {
        await _heroService.delete(hero.id);
        heroes.remove(hero);
        if (selected == hero) selected = null;
      }
    }
    ```

3.  `src/hero_list_component.html`を修正！

    ```html
    <ul class="heroes">
        <li *ngFor="let hero of heroes" [class.selected]="hero === selected" (click)="onSelect(hero)">
            <!-- ↓IDと名前のスタイルを調整 -->
            <span class="badge">{{hero.id}}</span>
            <span>{{hero.name}}</span>
            <!-- 削除ボタンを追加！ -->
            <button class="delete" (click)="delete(hero); $event.stopPropagation()">x</button>
        </li>

        <!-- … -->

    </ul>
    ```

4.  `src/hero_list_component.css`を修正！

    ```css
    /* … */

    /* ↓削除ボタンのスタイルを定義！ */
    button.delete {
      float:right;
      margin-top: 2px;
      margin-right: .8em;
      background-color: gray !important;
      color:white;
    }
    ```

ブラウザを更新！
Heroリスト画面で削除ボタンを押してみよう！

変更が反映されて、ダッシュボードとHeroリストを行き来しても変更した内容が維持されていればOK！

※モックサーバーなのでブラウザを更新すると元に戻るよ！

ネクストッ

## ダッシュボードに検索ボックスを追加！

1.  `src/hero_search_service.dart`を作る！

    -   サーバーのWebAPIに検索クエリを送信する`serch`関数を定義！

    ```dart
    import 'dart:async';
    import 'dart:convert';

    import 'package:http/http.dart';

    import 'hero.dart';

    class HeroSearchService {
      final Client _http;

      HeroSearchService(this._http);

      Future<List<Hero>> search(String term) async {
        try {
          final response = await _http.get('app/heroes/?name=$term');
          return (_extractData(response) as List)
              .map((json) => Hero.fromJson(json))
              .toList();
        } catch (e) {
          throw _handleError(e);
        }
      }

      dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

      Exception _handleError(dynamic e) {
        print(e); // for demo purposes only
        return Exception('Server error; cause: $e');
      }
    }
    ```

2.  `src/hero_search_component.dart`を作る！

    ```dart
    import 'dart:async';
    import 'package:angular/angular.dart';
    import 'package:angular_router/angular_router.dart';
    import 'package:stream_transform/stream_transform.dart';
    import 'route_paths.dart';
    import 'hero_search_service.dart';
    import 'hero.dart';

    @Component(
      selector: 'hero-search',
      templateUrl: 'hero_search_component.html',
      styleUrls: ['hero_search_component.css'],
      directives: [coreDirectives],
      providers: [ClassProvider(HeroSearchService)],
      pipes: [commonPipes],
    )
    class HeroSearchComponent implements OnInit {
      HeroSearchService _heroSearchService;
      Router _router;

      Stream<List<Hero>> heroes;

      // ↓このストリームはユーザーが入力したHero名の検索パターンを表す！
      StreamController<String> _searchTerms = StreamController<String>.broadcast();

      HeroSearchComponent(this._heroSearchService, this._router) {}

      // ↓テンプレートから呼び出す関数！
      // ↓ストリームに、フォームに入力されたテキストを追加
      // ↓ユーザーの入力を直接サーバーへ送信すると、
      // ↓通信量が非常に多くなってしまうリスクがある！
      // ↓検索パターンを一旦ストリームに格納して文字列を精査することで、通信回数を抑えることができる！
      void search(String term) => _searchTerms.add(term);

      void ngOnInit() async {
        heroes = _searchTerms.stream
            // ↓300ms間ユーザーの入力が停止するのを待つ！
            // ↓これにより過度な通信を抑える！
            .transform(debounce(Duration(milliseconds: 300)))
            // ↓文字列が変更されたときだけ通信する！
            .distinct()
            // ↓以前の検索をキャンセルして、最新の検索のみ返す！
            .transform(switchMap((term) => term.isEmpty
                ? Stream<List<Hero>>.fromIterable([<Hero>[]])
                : _heroSearchService.search(term).asStream()))
            .handleError((e) {
          print(e); // for demo purposes only
        });
      }

      String _heroUrl(int id) =>
          RoutePaths.hero.toUrl(parameters: {idParam: '$id'});

      Future<NavigationResult> gotoDetail(Hero hero) =>
          _router.navigate(_heroUrl(hero.id));
    }
    ```

3.  `src/hero_search_component.html`を作る！

    ```html
    <div id="search-component">
        <h4>Hero Search</h4>
        <!-- ↓検索ボックス -->
        <!-- ↓changeはユーザーがマウスでコピペしたとき等！ -->
        <!-- ↓keyupはユーザーがキー入力したときに呼ばれる！ -->
        <input #searchBox id="search-box" (change)="search(searchBox.value)" (keyup)="search(searchBox.value)" />
        <div>
            <!-- ↓検索結果のリスト -->
            <div *ngFor="let hero of heroes | async" (click)="gotoDetail(hero)" class="search-result">
                {{hero.name}}
            </div>
        </div>
    </div>
    ```

4.  `src/hero_search_component.css`を作る！

    ```css
    .search-result {
      border-bottom: 1px solid gray;
      border-left: 1px solid gray;
      border-right: 1px solid gray;
      width:195px;
      height: 20px;
      padding: 5px;
      background-color: white;
      cursor: pointer;
    }
    #search-box {
      width: 200px;
      height: 20px;
    }
    ```

5.  `src/dashboard_component.dart`を修正！

    ```dart
    // …

    // ↓追加！
    import 'hero_search_component.dart';

    // …

      directives: [
        coreDirectives,
        routerDirectives,
        // ↓追加！
        HeroSearchComponent,
      ],

    // …
    ```

6.  `src/dashboard_component.html`を修正！

    ```html
    <!-- … -->

    <!-- ↓検索ボックスを追加！ -->
    <hero-search></hero-search>
    ```

ブラウザを更新！
検索ボックスに文字を入力してみよう！
こんな感じで表示されたらOK！
（ひさびさのスクショ！）
＜スクショ＞

フィニッシュ！！！！
