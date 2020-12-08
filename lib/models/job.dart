import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable(explicitToJson: true)
class Job {
  String id;
  DateTime invoiceDate;
  String address;
  double hours;
  double hourRate;
  String byUserId;

  Job({
    this.id,
    this.invoiceDate,
    this.address,
    this.hours,
    this.hourRate,
    this.byUserId,
  });

  factory Job.fromSnapshot(DocumentSnapshot snapshot) {
    Job data = Job.fromJson(snapshot.data());
    data.id = snapshot.id;
    return data;
  }

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
  Map<String, dynamic> toJson() => _$JobToJson(this);
}
