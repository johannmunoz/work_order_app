import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:work_order_app/ui/shared/ui_helpers.dart';
import 'package:work_order_app/ui/views/sign_up/sign_up_viewmodel.dart';
import 'package:work_order_app/ui/widgets/busy_button.dart';
import 'package:work_order_app/ui/widgets/input_field.dart';

class SignupView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      onModelReady: (model) {
        SystemChrome.setPreferredOrientations(
          [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
        );
      },
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) {
        var mediaQuery = MediaQuery.of(context);
        bool isKeyboardOpen = false;
        if (mediaQuery.viewInsets.bottom > 0) isKeyboardOpen = true;

        return GestureDetector(
          onTap: () {
            _emailFocusNode.unfocus();
            _passwordFocusNode.unfocus();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    verticalSpaceSmall,
                    // _LogoImage(shrink: isKeyboardOpen),
                    isKeyboardOpen ? verticalSpaceSmall : verticalSpaceLarge,
                    InputField(
                      placeholder: 'Your Email',
                      controller: emailController,
                      fieldFocusNode: _emailFocusNode,
                      nextFocusNode: _passwordFocusNode,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Password',
                      password: true,
                      controller: passwordController,
                      fieldFocusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.go,
                      enterPressed: () => model.login(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceSmall,
                    isKeyboardOpen ? verticalSpaceSmall : verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: BusyButton(
                            title: 'SIGN UP',
                            busy: model.isBusy,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                model.login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LogoImage extends StatelessWidget {
  final bool shrink;
  const _LogoImage({
    Key key,
    this.shrink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    double maxWidth = 150.0;
    if (mediaQuery.size.width < 480) {
      if (shrink) maxWidth = 100.0;
    } else {
      maxWidth = 300.0;
    }
    return SizedBox(
      height: maxWidth,
      // child: Image.asset('assets/images/logo.png'),
    );
  }
}
