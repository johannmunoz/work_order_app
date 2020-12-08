import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_order_app/ui/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.getJobs(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Jobs'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => model.logout(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => model.goToNewJob(),
        ),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.jobs.isEmpty
                ? Center(child: Text('No jobs found'))
                : ListView.builder(
                    itemCount: model.jobs.length,
                    itemBuilder: (context, index) {
                      final job = model.jobs[index];
                      return ListTile(
                        title: Text(job.address),
                        subtitle: Text(
                          job.date.toIso8601String(),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
