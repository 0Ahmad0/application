import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';

import 'widgets/notifications_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: ColorManager.black,),
        title: Text(AppStringsManager.notfication),
      ),
      body: NotificationViewBody(),
    );
  }
}
