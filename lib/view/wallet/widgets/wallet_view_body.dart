
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/view/charge_wallet/charge_wallet_view.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletViewBody extends StatelessWidget {
  const WalletViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
        Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p80,
                vertical: AppPadding.p20,
              ),
              margin: const EdgeInsets.only(top: AppMargin.m40),
              width: double.infinity,
              height: 20.h,
              decoration: BoxDecoration(
                  color: ColorManager.secondaryColor,
                  borderRadius: BorderRadius.circular(6.sp)),
              child: InkWell(
                onTap: (){
                  Get.to(()=>ChargeWalletView());
                },
                child: Container(
                  height: 14.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.sp),
                      border: Border.all(color: ColorManager.white)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetsManager.add_creditIMG),
                      const SizedBox(
                        width: AppSize.s6,
                      ),
                      Text(
                        AppStringsManager.add_credit,
                        style: getRegularStyle(color: ColorManager.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 20.w,
              right: 20.w,
              child: Container(
                padding: const EdgeInsets.all(AppPadding.p16),
                width: SizerUtil.width / 2,
                height: 12.h,
                decoration: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.circular(6.sp)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetsManager.walletIMG),
                        const SizedBox(
                          width: AppSize.s6,
                        ),
                        Text(
                          AppStringsManager.total_wallet,
                          style: getRegularStyle(color: ColorManager.white),
                        )
                      ],
                    ),
                    Spacer(),
                    Text(
                      '900 ر.س',
                      style: getRegularStyle(color: ColorManager.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
        Row(
          children: [
            Icon(
              Icons.refresh,
              color: ColorManager.primaryColor,
              size: 16.sp,
            ),
            const SizedBox(
              width: AppSize.s6,
            ),
            const Text(AppStringsManager.all_movements)
          ],
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        const Divider(
          thickness: 1.2,
          color: ColorManager.hintColor,
        ),
        for (int i = 0; i < 10; i++)
          Column(
            children: [
              ListTile(
                contentPadding:const EdgeInsets.symmetric(
                  vertical: AppPadding.p6,
                ),
                leading: SizedBox(
                  width: (SizerUtil.width / 3),
                  child: Text('${AppStringsManager.movement + '\n' + (i.isEven?
                  AppStringsManager.add_credit:AppStringsManager.participate_in_course)}'),
                ),
                title: Center(child: Text('105.00'),),
                trailing: SizedBox(
                  width: 30.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetsManager.appointmentsIMG),
                      Text('${DateFormat().add_yMd().format(DateTime.now())}')
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1.2,
                color: ColorManager.hintColor,
              )
            ],
          )
      ],
    );
  }
}
