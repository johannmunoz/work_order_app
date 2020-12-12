import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final TextEditingController dateController = TextEditingController();
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
      child: Column(
        children: [
          verticalSpaceLarge,
          TextFormField(
            initialValue: widget.initialValue.address,
            decoration: InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) => job.address = value,
          ),
          verticalSpaceLarge,
          TextFormField(
            initialValue: widget.initialValue.hours.toString(),
            decoration: InputDecoration(
              labelText: 'Hours',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSaved: (value) => job.hours = double.tryParse(value),
          ),
          verticalSpaceLarge,
          TextFormField(
            initialValue: widget.initialValue.hourRate.toString(),
            decoration: InputDecoration(
              labelText: 'Hours Rate',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSaved: (value) => job.hourRate = double.tryParse(value),
          ),
          verticalSpaceLarge,
          TextField(
            onTap: () async {
              final datePicked = await _pickDate(context, dateController);
              job.date = datePicked;
              FocusScope.of(context).requestFocus(FocusNode());
            },
            controller: dateController,
            decoration: InputDecoration(
              labelText: 'Job date',
              suffixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
          ),
          verticalSpaceLarge,
        ],
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
