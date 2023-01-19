import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/view/chat/widgets/chat_room.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/container_icons.dart';
import '../../resourse/assets_manager.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/string_manager.dart';
import '../../resourse/style_manager.dart';

class AppointmentsViewBody extends StatelessWidget {
  const AppointmentsViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
        Text(
          AppStringsManager.appointments,
          style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        //TODO :
        for (int i = 0; i < 2; i++)
          buildCoursesDetails(
              onProgress: i == 0 ? true : false,
              color: i == 0
                  ? Colors.amber
                  : i == 1
                      ? Colors.green
                      : Colors.red,
              statusText: i == 0
                  ? AppStringsManager.ongoing
                  : i == 1
                      ? AppStringsManager.completed
                      : AppStringsManager.cancelled)
      ],
    );
  }

  Widget buildCoursesDetails(
      {onProgress = false, required color, required statusText}) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.sp),
        border: Border.all(color: ColorManager.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AssetsManager.trainer_course_nameIMG),
                    const SizedBox(
                      width: AppSize.s4,
                    ),
                    const Text(AppStringsManager.trainer_courses_name),
                    const SizedBox(
                      width: AppSize.s4,
                    ),
                    Text(
                      '(للمبتدئين)',
                      style: getRegularStyle(color: ColorManager.lightGray),
                    ),
                  ],
                ),
                Container(
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
                )
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(right: AppPadding.p30),
              child: Column(
                children: [
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  const Text('هذه المكان مخصص لوضع عنوان مناسب للدورة المقدمة'),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(
                    children: [
                      Text(
                        AppStringsManager.show_trainer_course_details,
                        style: getRegularStyle(
                            color: ColorManager.primaryColor, fontSize: 10.sp),
                      ),
                    ],
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
          const SizedBox(
            height: AppSize.s10,
          ),
          Visibility(
            visible: onProgress,
            child: Row(
              children: [
                Expanded(
                  child: ButtonApp(
                    radius: 100.sp,
                    height: AppSize.s50,
                    fontSize: 10.sp,
                    text: AppStringsManager.start_conversation,
                    onPressed: () {
                      Get.to(()=>ChatRoom(),transition: Transition.downToUp);
                    },
                  ),
                ),
                const SizedBox(width: AppSize.s10,),
                Expanded(
                  child: ButtonApp(
                    borderColor: ColorManager.primaryColor,
                    color: ColorManager.white,
                    textColor: ColorManager.primaryColor,
                    radius: 100.sp,
                    fontSize: 10.sp,
                    height: AppSize.s50,
                    text: AppStringsManager.cancellation_booking,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
