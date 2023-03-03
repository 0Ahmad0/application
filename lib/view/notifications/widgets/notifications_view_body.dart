import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/provider/notification_provider.dart';
import '../../../model/models.dart';
import '../../../model/models.dart' as model;
import '../../../model/utils/const.dart';
import '../../../model/utils/consts_manager.dart';
import '../../resourse/color_manager.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({Key? key, required this.notificationProvider, required this.profileProvider}) : super(key: key);
  final NotificationProvider notificationProvider;
  final ProfileProvider profileProvider;

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {

  var getNotification;

  getNotificationFun()  {
    getNotification = FirebaseFirestore.instance.collection(AppConstants.collectionNotification)
        .where('checkRec',isEqualTo: false)
    .where('idUser',isEqualTo: widget.profileProvider.user.id)
        .snapshots();
    return getNotification;
  }
  @override
  void initState() {
    getNotificationFun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      //prints the messages to the screen0
        stream: getNotification,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return
              Const.SHOWLOADINGINDECATOR();

          }
          else if (snapshot.connectionState ==
              ConnectionState.active) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              Const.SHOWLOADINGINDECATOR();
              widget.notificationProvider.notifications.listNotification.clear();
              if(snapshot.data!.docs!.length>0){
                widget.notificationProvider.notifications=Notifications.fromJson(snapshot.data!.docs!);
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16, vertical: AppPadding.p10),
                itemBuilder: (_, index) =>
                    FadeInRightBig(child: BuildNotificationItem(index: index
                       ,notification: widget.notificationProvider.notifications.listNotification[index]
                    )),
                itemCount: widget.notificationProvider.notifications.listNotification.length,
              );
              /// }));
            } else {
              return const Text('Empty data');
            }
          }
          else {
            return Text('State: ${snapshot.connectionState}');
          }
        });
  }
}

class BuildNotificationItem extends StatelessWidget {
  final int index;
  final model.Notification notification;
  const BuildNotificationItem({super.key, required this.index, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
      decoration: BoxDecoration(
          color: ColorManager.white,
          border: Border.all(color: ColorManager.borderColor),
          borderRadius: BorderRadius.circular(5.sp)),
      child: ListTile(
        onTap: (){},
        leading: CircleAvatar(
          backgroundColor: index.isOdd
              ? ColorManager.secondaryColor
              : ColorManager.borderColor,
          child: SvgPicture.asset(
            AssetsManager.notficationIMG,
            color: ColorManager.white,
          ),
        ),
        title: Text(
          notification.title,
         // 'هذه المكان مخصص لوضع عنوان الاشعار.',
          style: getRegularStyle(
            color: ColorManager.black,
            fontSize: 12.sp
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppPadding.p12),
          child: Text(
            notification.subtitle
            // 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة'
            //   '، لقد  تم توليد هذا النص من مولد النص العربى'
            ,style: TextStyle(
            fontSize: 10.sp
          ),),

        ),
        trailing: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text('${DateFormat().add_Hm().format(notification.dateTime)}',

          style: TextStyle(
            fontSize: 10.sp
          ),
          ),
        ),
      ),
    );
  }
}
