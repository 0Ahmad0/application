import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../manager/widgets/button_app.dart';
import '../../../manager/widgets/container_icons.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';

class AdminRequestViewBody extends StatelessWidget {
  const AdminRequestViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStringsManager.requests,
            style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, index) => BuildAdminRequestItem(index: index),
          ))
        ],
      ),
    );
  }
}

class BuildAdminRequestItem extends StatelessWidget {
  final int index;

  const BuildAdminRequestItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.sp),
          border: Border.all(color: ColorManager.borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  color: ColorManager.borderColor,
                  child: Image.asset(
                    'assets/images/1.png',
                  )),
            ),
            const SizedBox(
              width: AppSize.s10,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('عبير عبد الغني'),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: AppPadding.p14),
                        child: Text(
                          'رخصة عمل حر',
                          style: getRegularStyle(
                              color: ColorManager.black, fontSize: 10.sp),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AssetsManager.locationIMG),
                        const SizedBox(width: AppSize.s4,),
                        Flexible(
                            child: Text(
                          'جدة, حي نظار, شارع النور',
                          style: getRegularStyle(
                            color: ColorManager.lightGray,
                            fontSize: 10.sp
                          ),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonApp(
                            color: ColorManager.thirdlyColor,
                            height: AppSize.s40,
                            fontSize: 10.sp,
                            text: AppStringsManager.acception_trainer,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          width: AppSize.s4,
                        ),
                        Expanded(
                          child: ButtonApp(
                            borderColor: ColorManager.thirdlyColor,
                            color: ColorManager.white,
                            textColor: ColorManager.thirdlyColor,
                            fontSize: 10.sp,
                            height: AppSize.s40,
                            text: AppStringsManager.trainer_details,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}
