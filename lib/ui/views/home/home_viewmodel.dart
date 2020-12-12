import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:work_order_app/app/locator.dart';
import 'package:work_order_app/app/router.gr.dart';
import 'package:work_order_app/models/job.dart';
import 'package:work_order_app/services/authentication_service.dart';
import 'package:work_order_app/services/excel_service.dart';
import 'package:work_order_app/services/firestore_service.dart';

class HomeViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final ExcelService _excelService = locator<ExcelService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Job> _jobs;
  List<Job> get jobs => _jobs;

  Future logout() async {
    final result = await _dialogService.showConfirmationDialog(
        title: 'Are you sure?', description: 'Would you like to log out?');

    if (result.confirmed) {
      await _authenticationService.logout();
      _navigationService.clearStackAndShow(Routes.loginView);
    }
  }

  goToNewJob() {
    _navigationService.navigateTo(Routes.newJobView);
  }

  getJobs() async {
    setBusy(true);
    final jobs = await _firestoreService.getJobs();

    if (jobs != null) {
      _jobs = jobs;
    }
    setBusy(false);
  }

  exportJobsToExcel() async {
    try {
      await _excelService.createFileWithJobs(_jobs);
      _snackbarService.showSnackbar(message: 'File successfully exported!');
    } catch (e) {
      _snackbarService.showSnackbar(
          message: 'There was an error exporting the file');
    }
  }
}
