import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:work_order_app/app/locator.dart';
import 'package:work_order_app/app/router.gr.dart';
import 'package:work_order_app/models/job.dart';
import 'package:work_order_app/services/firestore_service.dart';

class NewJobViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  addNewJob(Job job) async {
    setBusy(true);
    final ref = await _firestoreService.createJob(job);
    print('New job: $ref');

    await _navigationService.clearStackAndShow(Routes.homeView);

    setBusy(false);
  }
}
