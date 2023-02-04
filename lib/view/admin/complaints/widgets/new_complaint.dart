import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../manager/widgets/button_app.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
import '../../../resourse/values_manager.dart';

class NewComplaint extends StatelessWidget {
  const NewComplaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) => BuildNewComplaintItem(index: index),
    );
  }
}

class BuildNewComplaintItem extends StatelessWidget {
  final int index;

  const BuildNewComplaintItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.sp),
              border: Border.all(color: ColorManager.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    buildTopContainerSection(
                        icon: AssetsManager.profileIMG,
                        title: AppStringsManager.complainant,
                        subtitle: 'عبير محمد'),
                    buildTopContainerSection(
                        icon: AssetsManager.send_complaintIMG,
                        title: AppStringsManager.number_complaint,
                        subtitle: '5517'),
                    buildTopContainerSection(
                        icon: AssetsManager.appointmentsIMG,
                        title: AppStringsManager.date_complaint,
                        subtitle: '${DateFormat.yMd().format(DateTime.now())}'),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Text(
                  AppStringsManager.complaint_details,
                  style: getRegularStyle(
                      color: ColorManager.secondaryColor, fontSize: 10.sp),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Text(
                  'هذا النص هو مثال لنص يمكن أن يستبدل نفس المساحة'
                  'لقد تم توليد هذا النص من مولد النص العر حيث يمكنك أن'
                  'الأخرى إضافة إلى زيادة',
                  style: getRegularStyle(
                      color: ColorManager.lightGray, fontSize: 10.sp),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
              ],
            )),
        Positioned(
          left: 14.sp,
          bottom: 0.0,
          child: InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: 24.w,
              padding: EdgeInsets.all(AppPadding.p8),
              decoration: BoxDecoration(
                  color: ColorManager.thirdlyColor,
                  borderRadius: BorderRadius.circular(4.sp)),
              child: Text(
                AppStringsManager.answer,
                style: getRegularStyle(color: ColorManager.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildTopContainerSection(
      {required icon, required title, required subtitle}) {
    return Expanded(
        child: ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                color: ColorManager.secondaryColor,
              ),
              const SizedBox(
                width: AppSize.s4,
              ),
              FittedBox(
                child: Text(
                  title,
                  style: getRegularStyle(
                      color: ColorManager.black, fontSize: 12.sp),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSize.s6,
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.p24),
            child: Text(
              subtitle,
              style:
                  getRegularStyle(color: ColorManager.black, fontSize: 10.sp),
            ),
          ),
        ],
      ),
    ));
  }
}
