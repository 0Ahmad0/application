import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:pinkey/view/resourse/color_manager.dart';

import '../../../controller/auth_controller.dart';
import 'widgets/complete_information_view_body.dart';

class CompleteInformationView extends StatelessWidget {
  const CompleteInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController=AuthController(context: context);
    return Scaffold(
      body: CompleteInformationViewBody(authController:authController),
    );
  }
}
