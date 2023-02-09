import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../controller/provider/process_provider.dart';
import '../../../../controller/provider/report_provider.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
import '../../../resourse/values_manager.dart';
class OldComplaint extends StatelessWidget {
   OldComplaint({Key? key}) : super(key: key);
  late ReportProvider reportProvider;
  @override
  Widget build(BuildContext context) {
    reportProvider =Provider.of<ReportProvider>(context);
    return ListView.builder(
      itemCount: reportProvider.listoldReport.length,
      itemBuilder: (_, index) => BuildOldComplaintItem(index: index,reportProvider:reportProvider),
    );
  }
}

class BuildOldComplaintItem extends StatelessWidget {
  final int index;
  final ReportProvider reportProvider;
  const BuildOldComplaintItem({super.key, required this.index, required this.reportProvider});

  @override
  Widget build(BuildContext context) {
    ProcessProvider processProvider =Provider.of<ProcessProvider>(context);
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
                        subtitle:processProvider.fetchLocalNameUser(idUser: reportProvider.listoldReport[index].idUser)  //'عبير محمد'
                    ),
                    buildTopContainerSection(
                        icon: AssetsManager.send_complaintIMG,
                        title: AppStringsManager.number_complaint,
                        subtitle:reportProvider.listoldReport[index].numReport// '5517'
                    ),
                    buildTopContainerSection(
                        icon: AssetsManager.appointmentsIMG,
                        title: AppStringsManager.date_complaint,
                        subtitle: '${DateFormat.yMd().format(reportProvider.listoldReport[index].dateTime)}'),
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
    reportProvider.listoldReport[index].details,
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
