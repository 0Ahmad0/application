import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/button_app.dart';
import '../../manager/widgets/confirm_dialog.dart';
import '../../manager/widgets/container_icons.dart';

class PaymentForCourseViewBody extends StatelessWidget {
  PaymentForCourseViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              decoration:  BoxDecoration(
                color: ColorManager.secondaryColor,
                borderRadius: BorderRadius.circular(6.sp),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    SvgPicture.asset(AssetsManager.walletIMG),
                    const SizedBox(width: AppSize.s8,),
                    Text(AppStringsManager.total_wallet,style: getRegularStyle(
                      color: ColorManager.white
                    ),)
                  ],
                ),
                trailing: Text('8200 ر.س',style: getRegularStyle(
                    color: ColorManager.white
                ),),
              ),
            ),
            onTap: (){
              //TODO: Navigator to wallet
            },
          ),
          const SizedBox(height: AppSize.s30,),
          const Text(AppStringsManager.course_cars),
          const SizedBox(height: AppSize.s10,),
          DropdownButtonFormField(
            items: [
            for(int i =0 ; i < carsType.length ; i++)
              DropdownMenuItem(
                child: Text(carsType[i]),
                value: carsType[i],
              )
          ], onChanged: (value){},
            icon:  Icon(Icons.keyboard_arrow_down,color: ColorManager.black.withOpacity(.3),),
          decoration:  InputDecoration(
              errorBorder: borderStyle,
              focusedBorder: borderStyle,
              enabledBorder: borderStyle,
              border: borderStyle,
            hintText: carsType.first,
            hintStyle: TextStyle(
              fontSize: 10.sp,
              color: ColorManager.hintColor
            )
          ),
          ),
          const SizedBox(height: AppSize.s30,),
          const Text(AppStringsManager.course_details),
          const SizedBox(height: AppSize.s10,),
          buildCoursesDetails(),
          const Spacer(),
          ButtonApp(text: AppStringsManager.booking_confirmation, onPressed: ()=>showBookingConfirmDialog(context))
        ],
      ),
    );
  }
  final borderStyle = const OutlineInputBorder(
      borderSide: BorderSide(color: ColorManager.hintColor)
  );
  List<String> carsType = [
    AppStringsManager.my_car,
    AppStringsManager.trainer_car,
  ];

  Widget buildCoursesDetails(){
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
            subtitle: Padding(
              padding: const EdgeInsets.only(right: AppPadding.p30),
              child: Column(
                children: [
                  const SizedBox(height: AppSize.s10,),
                  const Text('هذه المكان مخصص لوضع عنوان مناسب للدورة المقدمة'),
                  const SizedBox(height: AppSize.s10,),
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
          const SizedBox(height: AppSize.s10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildContainerDetailsTrainer(
                  text: 'سيارتي 900 ر.س',
                  icon: Icon(
                    Icons.monetization_on,
                    size: 16.sp,
                    color: ColorManager.secondaryColor,
                  )),
              buildContainerDetailsTrainer(
                  text: 'المتدربة 800 ر.س',
                  icon: Icon(
                    Icons.monetization_on,
                    size: 16.sp,
                    color: ColorManager.secondaryColor,
                  )),
              buildContainerDetailsTrainer(
                  text: '4 أيام',
                  icon: SvgPicture.asset(
                    AssetsManager.appointmentsIMG,
                    color: ColorManager.secondaryColor,
                    width: 16.sp,
                    height: 16.sp,
                  )),
            ],
          ),
        ],
      ),
    );
  }

}
