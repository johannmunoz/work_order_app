import 'package:c_link/app/locator.dart';
import 'package:c_link/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:c_link/app/router.gr.dart';

class StartUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      if (_authenticationService.hasSelectedBuilding()) {
        _navigationService.replaceWith(Routes.dashboardView);
      } else {
        _navigationService.replaceWith(Routes.buildingSelectionView);
      }
    } else {
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
