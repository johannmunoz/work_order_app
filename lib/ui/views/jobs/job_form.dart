import 'dart:async';

import 'package:flutter/material.dart';
import 'package:work_order_app/models/job.dart';
import 'package:work_order_app/ui/shared/ui_helpers.dart';

class JobForm extends StatefulWidget {
  final Job initialValue;
  final StreamController controller;
  final Function(Job) onSave;

  JobForm({
    Key key,
    @required this.initialValue,
    @required this.controller,
    @required this.onSave,
  }) : super(key: key);

  @override
  _JobFormState createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  final _formKey = GlobalKey<FormState>();
  Job job = Job.blank();
  @override
  void initState() {
    widget.controller.stream.listen(onSaveForm);
    super.initState();
  }

  void onSaveForm(_) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.onSave(job);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpaceMedium,
            TextFormField(
              initialValue: widget.initialValue.address,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              onSaved: (value) => job.address = value,
            ),
            verticalSpaceMedium,
            TextFormField(
              initialValue: widget.initialValue.hours.toString(),
              decoration: InputDecoration(
                labelText: 'Hours',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) => job.hours = double.tryParse(value),
            ),
            verticalSpaceMedium,
            TextFormField(
              initialValue: widget.initialValue.hourRate.toString(),
              decoration: InputDecoration(
                labelText: 'Hours Rate',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) => job.hourRate = double.tryParse(value),
            ),
            verticalSpaceMedium,
            CalendarDatePicker(
              firstDate: widget.initialValue.date.subtract(Duration(days: 365)),
              initialDate: widget.initialValue.date,
              lastDate: widget.initialValue.date.add(Duration(days: 365)),
              onDateChanged: (DateTime value) => job.date = value,
            ),
            verticalSpaceLarge,
          ],
        ),
      ),
    );
  }
}
