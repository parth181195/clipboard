import 'package:clipboarda/app/app.locator.dart';
import 'package:clipboarda/app/app.router.dart';
import 'package:clipboarda/services/UserAuthService.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase/supabase.dart';

class LoginViewModel extends BaseViewModel {
  final UserAuthService _userAuthService = locator<UserAuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  final MultiValidator emailValidators = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter A valid Email')
  ]);
  final MultiValidator passwordValidators = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
  ]);
  LoginPageMode mode = LoginPageMode.login;
  bool showPassword = false;

  changeMode() {
    mode = mode == LoginPageMode.login
        ? LoginPageMode.signUp
        : LoginPageMode.login;
    notifyListeners();
  }

  toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  login() async {
    final response = await _userAuthService.login(
      emailController.value.text,
      passwordController.value.text,
    );
    if (response.error == null) {
      _snackbarService.showSnackbar(message: 'Login Successful');
      _navigationService.clearStackAndShow(Routes.homeView);
    } else {
      _snackbarService.showSnackbar(message: response.error?.message ?? '');
    }
  }

  signUp() async {
    final GotrueSessionResponse response = await _userAuthService.signUp(
      emailController.value.text,
      passwordController.value.text,
    );
    if (response.error == null) {
      _snackbarService.showSnackbar(message: 'Login Successful');
      _navigationService.clearStackAndShow(Routes.homeView);
    } else {
      _snackbarService.showSnackbar(message: response.error?.message ?? '');
    }
  }
}

enum LoginPageMode { login, signUp }
