import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:work_order_app/app/locator.dart';
import 'package:work_order_app/app/router.gr.dart';
import 'package:work_order_app/services/excel_service.dart';
import 'package:work_order_app/services/firestore_service.dart';

class ExportFileViewModel extends BaseViewModel {
  final ExcelService _excelService = locator<ExcelService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  DateTime _startDate;
  DateTime _endDate;

  void exportJobsToExcel() async {
    try {
      final isInvalid = _validateDates();
      if (isInvalid != null) {
        _snackbarService.showSnackbar(message: isInvalid);
        return;
      }
      final jobs = await _firestoreService.getJobs(_startDate, _endDate);

      await _excelService.createFileWithJobs(jobs, _startDate, _endDate);
      await _navigationService.clearStackAndShow(Routes.homeView);
      _snackbarService.showSnackbar(message: 'File successfully exported!');
    } catch (e) {
      _snackbarService.showSnackbar(
          message: 'There was an error exporting the file');
    }
  }

  void setStartDate(DateTime date) {
    _startDate = date;
  }

  void setEndDate(DateTime date) {
    _endDate = date;
  }

  String _validateDates() {
    if (_startDate != null && _endDate != null) {
      if (_startDate.isAfter(_endDate)) {
        return 'Start date can\'t be after end date';
      }
    }
    return null;
  }
}
