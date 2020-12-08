import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_order_app/ui/views/startup/startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: _StartUpWidget(),
      ),
    );
  }
}

class _StartUpWidget extends StatelessWidget {
  const _StartUpWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // SizedBox(
          //   width: 300,
          //   height: 100,
          //   child: Image.asset('assets/images/logo.png'),
          // ),
          CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(
              Color(0xff19c7c1),
            ),
          )
        ],
      ),
    );
  }
}
