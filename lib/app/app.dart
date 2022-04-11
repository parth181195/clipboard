import 'package:clipboarda/services/SupaclientService.dart';
import 'package:clipboarda/services/UserAuthService.dart';
import 'package:clipboarda/ui/views/home/HomeView.dart';
import 'package:clipboarda/ui/views/login/LoginView.dart';
import 'package:clipboarda/ui/views/splash/SplashView.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(
    page: LoginView,
  ),
  MaterialRoute(
    page: HomeView,
  ),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: UserAuthService),
  LazySingleton(classType: SupaclientService),
])
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
