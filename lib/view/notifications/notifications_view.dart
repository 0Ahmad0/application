import 'package:flutter/material.dart';
import 'package:pinkey/controller/provider/notification_provider.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';

import 'widgets/notifications_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);
    NotificationProvider notificationProvider= Provider.of<NotificationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: ColorManager.black,),
        title: Text(AppStringsManager.notfication),
      ),
      body: NotificationViewBody(profileProvider:profileProvider,notificationProvider:notificationProvider),
    );
  }
}
