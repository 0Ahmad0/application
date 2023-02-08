import 'package:flutter/material.dart';
import 'package:pinkey/controller/auth_controller.dart';

import 'widgets/welcome_view_body.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController=AuthController(context: context);
    return Scaffold(
      body: WelcomeViewBody(authController:authController),
    );
  }
}
