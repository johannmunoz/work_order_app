import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/app/locator.dart';
import 'package:work_order_app/models/job.dart';
import 'authentication_service.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthenticationService _as = locator<AuthenticationService>();

  Future<List<Job>> getJobs() async {
    List<Job> jobs = [];

    try {
      var snap = await _db
          .collection('jobs')
          .where('byUserId', isEqualTo: _as.uid)
          .orderBy('date', descending: true)
          .get();
      jobs = snap.docs.map((document) => Job.fromSnapshot(document)).toList();
    } on Exception catch (e) {
      print(e);
    }

    return jobs;
  }

  Future<String> createJob(Job job) async {
    job.byUserId = _as.uid;
    try {
      var docRef = await _db.collection('jobs').add(job.toJson());
      return docRef.id;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}
