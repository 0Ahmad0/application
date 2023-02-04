import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/button_app.dart';
import '../../manager/widgets/container_icons.dart';
import '../../resourse/assets_manager.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/string_manager.dart';
import '../../resourse/style_manager.dart';

class AllComplaint extends StatelessWidget {
  const AllComplaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStringsManager.complaint),
        leading: const BackButton(
          color: ColorManager.black,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            padding: const EdgeInsets.all(AppPadding.p16),
            children: [
              Text(AppStringsManager.all_complaint),
              const SizedBox(
                height: AppSize.s10,
              ),
              for(int i = 0 ; i < 5 ; i++)
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      margin: const EdgeInsets.symmetric(vertical: AppMargin.m20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.sp),
                        border: Border.all(color: ColorManager.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading:
                                  SvgPicture.asset(AssetsManager.send_complaintIMG),
                                  title: SizedBox(
                                      child: Text(
                                        AppStringsManager.number_complaint,
                                        style: getRegularStyle(
                                          color: ColorManager.secondaryColor,
                                        ),
                                      )),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: AppPadding.p6),
                                    child: Text(
                                      '158',
                                      style: getRegularStyle(
                                          color: ColorManager.lightGray, fontSize: 10.sp),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: SvgPicture.asset(
                                    AssetsManager.appointmentsIMG,
                                    color: ColorManager.secondaryColor,
                                  ),
                                  title: Text(
                                    AppStringsManager.date_complaint,
                                    style: getRegularStyle(
                                      color: ColorManager.secondaryColor,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: AppPadding.p6),
                                    child: Text(
                                      '${DateFormat.yMd().format(DateTime.now())}',
                                      style: getRegularStyle(
                                          color: ColorManager.lightGray, fontSize: 10.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSize.s10,),
                          Text(AppStringsManager.complaint_details,style: getRegularStyle(
                              color: ColorManager.black,
                              fontSize: 14.sp
                          ),),
                          const SizedBox(height: AppSize.s10,),
                          Text('هذا النص هو مثال لنص يمكن أن يستبدل نفس المساحة'
                              'لقد تم توليد هذا النص من مولد النص العر حيث يمكنك أن'
                              'الأخرى إضافة إلى زيادة'),
                          const SizedBox(height: AppSize.s10,),
                          Visibility(
                            //TODO:
                            visible: i.isOdd?false:true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStringsManager.complaint_replay,style: getRegularStyle(
                                    color: ColorManager.primaryColor,
                                    fontSize: 14.sp
                                ),),
                                const SizedBox(height: AppSize.s10,),
                                Text('هذا النص هو مثال لنص يمكن أن يستبدل نفس المساحة'
                                    'لقد تم توليد هذا النص من مولد النص العر حيث يمكنك أن'
                                    'الأخرى إضافة إلى زيادة'),
                                const SizedBox(height: AppSize.s10,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    i.isOdd?Positioned(
                      left: 20.sp,
                      bottom: 0.0,
                      child: Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        padding:const EdgeInsets.all(AppPadding.p12),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(6.sp),
                        ),
                        child: Text('قيد المراجعة'),
                      ),
                    ):SizedBox()
                  ],
                )

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: ButtonApp(text: AppStringsManager.send_new__complaint, onPressed: (){}),
          )
        ],
      ),
    );
  }
}
