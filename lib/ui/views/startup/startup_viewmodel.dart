import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:work_order_app/app/locator.dart';
import 'package:work_order_app/app/router.gr.dart';
import 'package:work_order_app/services/authentication_service.dart';

class StartUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.replaceWith(Routes.homeView);
    } else {
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
