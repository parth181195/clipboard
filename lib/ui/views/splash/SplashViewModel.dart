// ignore_for_file: prefer_const_constructors

import 'package:clipboarda/app/app.locator.dart';
import 'package:clipboarda/app/app.router.dart';
import 'package:clipboarda/services/UserAuthService.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase/supabase.dart';

class SplashViewModel extends BaseViewModel {
  final UserAuthService _userAuthService = locator<UserAuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  checkLogin() async {
    Future.delayed(Duration(seconds: 2)).then((value) {
      final User? user = _userAuthService.checkLogin();
      if (user != null) {
        _navigationService.replaceWith(Routes.homeView);
      } else {
        _navigationService.replaceWith(Routes.loginView);
      }
    });
  }
}
