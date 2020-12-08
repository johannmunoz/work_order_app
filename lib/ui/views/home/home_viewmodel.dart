import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:work_order_app/app/locator.dart';
import 'package:work_order_app/app/router.gr.dart';
import 'package:work_order_app/services/authentication_service.dart';

class HomeViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future logout() async {
    await _authenticationService.logout();
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  goToSignup() {
    _navigationService.navigateTo(Routes.signupView);
  }
}
