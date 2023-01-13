import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/view/chat/widgets/chat_room.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../manager/widgets/container_icons.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
class ExpiredAndCancelledRequestPage extends StatelessWidget {
  const ExpiredAndCancelledRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
         return ListView(
      children: [
        for (int i = 0; i < 3; i++)
          BuildExpiredAndCanclledRequestItem(
            color: i == 2?ColorManager.error:ColorManager.success,
            statusText: i == 2
                ? AppStringsManager.cancelled
                :AppStringsManager.completed
          )
      ],
    );

  }
  Widget BuildExpiredAndCanclledRequestItem({required color , required statusText}) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.sp),
        border: Border.all(color: ColorManager.borderColor),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    SvgPicture.asset(AssetsManager.profileIMG),
                    const SizedBox(
                      width: AppSize.s4,
                    ),
                    const Text(AppStringsManager.student_name),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      Text(
                        'رحمة منير الدهشان',
                        style: getRegularStyle(
                            color: ColorManager.secondaryColor,
                            fontSize: 10.sp),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              AppStringsManager.show_details_custom_course,
                              style: getRegularStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildContainerDetailsTrainer(
                      text: '${DateFormat.yMd().format(DateTime.now())}',
                      icon: SvgPicture.asset(
                        AssetsManager.appointmentsIMG,
                        color: ColorManager.secondaryColor,
                        width: 16.sp,
                        height: 16.sp,
                      )),
                  buildContainerDetailsTrainer(
                      text:
                      '${DateFormat().add_Hm().format(DateTime.now()) + ' - ' + DateFormat().add_Hm().format(DateTime.now())}',
                      icon: Icon(
                        Icons.access_time_filled,
                        size: 16.sp,
                        color: ColorManager.secondaryColor,
                      )),
                  buildContainerDetailsTrainer(
                      text: '800 ر.س',
                      icon: Icon(
                        Icons.monetization_on,
                        size: 16.sp,
                        color: ColorManager.secondaryColor,
                      )),
                ],
              ),


            ],
          ),
          Positioned(
              left: 0.sp,
              top: 0.sp,
              child: Container(
                alignment: Alignment.center,
                width: 20.w,
                padding: const EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(50.sp)),
                child: Text(
                  statusText,
                  style: getRegularStyle(
                      color: ColorManager.white, fontSize: 10.sp),
                ),
              )),
        ],
      ),
    );
  }

}
