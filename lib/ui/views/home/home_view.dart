import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_order_app/ui/shared/ui_helpers.dart';
import 'package:work_order_app/ui/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Work order app!'),
              verticalSpaceSmall,
              OutlineButton(
                onPressed: () => model.logout(),
                child: Text('LOGOUT'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
