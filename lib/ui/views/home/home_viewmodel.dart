import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:work_order_app/app/locator.dart';
import 'package:work_order_app/app/router.gr.dart';
import 'package:work_order_app/models/job.dart';
import 'package:work_order_app/services/authentication_service.dart';
import 'package:work_order_app/services/firestore_service.dart';

class HomeViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Job> _jobs;
  List<Job> get jobs => _jobs;

  Future logout() async {
    await _authenticationService.logout();
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  goToSignup() {
    _navigationService.navigateTo(Routes.signupView);
  }

  goToNewJob() {
    // _navigationService.navigateTo(routeName)
  }

  getJobs() async {
    setBusy(true);
    final jobs = await _firestoreService.getJobs();

    if (jobs != null) {
      _jobs = jobs;
    }
    setBusy(false);
  }
}
