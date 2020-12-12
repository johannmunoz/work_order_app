import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_order_app/models/job.dart';
import 'package:work_order_app/ui/views/jobs/job_form.dart';
import 'package:work_order_app/ui/views/jobs/new_job/new_job_viewmodel.dart';

class NewJobView extends StatelessWidget {
  final StreamController controller = StreamController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewJobViewModel>.reactive(
      viewModelBuilder: () => NewJobViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('New Job'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.add(true),
          label: Text('ADD JOB'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500.0),
                child: JobForm(
                  initialValue: Job.blank(),
                  controller: controller,
                  onSave: (job) => model.addNewJob(job),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
