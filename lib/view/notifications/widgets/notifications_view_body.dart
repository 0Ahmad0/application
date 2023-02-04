import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../resourse/color_manager.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16, vertical: AppPadding.p10),
      itemBuilder: (_, index) =>
          FadeInRightBig(child: BuildNotificationItem(index: index)),
      itemCount: 10,
    );
  }
}

class BuildNotificationItem extends StatelessWidget {
  final int index;

  const BuildNotificationItem({super.key, required this.index});

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
          'هذه المكان مخصص لوضع عنوان الاشعار.',
          style: getRegularStyle(
            color: ColorManager.black,
            fontSize: 12.sp
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppPadding.p12),
          child: Text('هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة'
              '، لقد  تم توليد هذا النص من مولد النص العربى',style: TextStyle(
            fontSize: 10.sp
          ),),

        ),
        trailing: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text('${DateFormat().add_Hm().format(DateTime.now())}',

          style: TextStyle(
            fontSize: 10.sp
          ),
          ),
        ),
      ),
    );
  }
}
