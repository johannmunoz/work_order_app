import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_order_app/ui/shared/ui_helpers.dart';
import 'package:work_order_app/ui/views/home/home_viewmodel.dart';
import 'package:work_order_app/utils/currency_helpers.dart';
import 'package:work_order_app/utils/date_helpers.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.getJobs(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Jobs'),
          elevation: 0,
          actions: [
            FlatButton(
              onPressed: model.exportJobsToExcel,
              child: Text(
                'EXPORT',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
              onPressed: model.logout,
              child: Text(
                'LOGOUT',
                style: TextStyle(color: Colors.white),
              ),
            ),
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
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    itemCount: model.jobs.length,
                    itemBuilder: (context, index) {
                      final job = model.jobs[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.home_outlined),
                                        Expanded(
                                          child: Text(
                                            job.address,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpaceSmall,
                                    Row(
                                      children: [
                                        Icon(Icons.date_range_outlined),
                                        Text(
                                          getFormattedDate(job.date),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                                Icons.monetization_on_outlined),
                                            Text(
                                                '\$${job.hourRate.toStringAsFixed(2)}'),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Icon(Icons.timer),
                                            Text(
                                                '${job.hours.toStringAsFixed(1)} hours'),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    verticalSpaceSmall,
                                    Text(
                                        'Total: ${getTotal(job.hourRate, job.hours)}')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      // return ListTile(
                      //   title: Text(job.address),
                      //   subtitle: Text(
                      //     getFormattedDate(job.date),
                      //   ),
                      // );
                    },
                  ),
      ),
    );
  }
}
