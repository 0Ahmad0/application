import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_controller.dart';
import '../../controller/provider/profile_provider.dart';
import 'widgets/edit_password_view_body.dart';

class EditPassordView extends StatelessWidget {
  const EditPassordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppStringsManager.edit_password),
        leading: BackButton(color: ColorManager.black,),
      ),
      body: EditPasswordViewBody(profileProvider:Provider.of<ProfileProvider>(context), authController: AuthController(context: context)),
    );
  }
}
