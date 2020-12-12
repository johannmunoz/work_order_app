import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:work_order_app/ui/shared/ui_helpers.dart';
import 'package:work_order_app/ui/views/jobs/export_file/export_file_viewmodel.dart';

class ExportFileView extends StatelessWidget {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExportFileViewModel>.reactive(
      viewModelBuilder: () => ExportFileViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Export File'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('EXPORT'),
          onPressed: () => model.exportJobsToExcel(),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceMedium,
                  Text('Select report start date:'),
                  verticalSpaceSmall,
                  TextField(
                    onTap: () async {
                      final datePicked =
                          await _pickDate(context, startDateController);
                      model.setStartDate(datePicked);
                    },
                    controller: startDateController,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  verticalSpaceMedium,
                  Text('Select report end date:'),
                  verticalSpaceSmall,
                  TextField(
                    onTap: () async {
                      final datePicked =
                          await _pickDate(context, endDateController);
                      model.setEndDate(datePicked);
                    },
                    controller: endDateController,
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime> _pickDate(
      BuildContext context, TextEditingController controller) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2100),
    );
    if (date == null) return null;
    final formattedDate = DateFormat("dd/MM/yyyy").format(date);
    controller.text = formattedDate;
    return date;
  }
}
