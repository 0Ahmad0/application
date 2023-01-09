import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:sizer/sizer.dart';

import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';

showBookingConfirmDialog(context,{text = '1145'}){
  Get.dialog(
      Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            height: (SizerUtil.height / 2) - 16,
            margin: const EdgeInsets.all(AppMargin.m16),
            padding: const EdgeInsets.all(AppPadding.p20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                color: ColorManager.white
            ),
            child: Column(
              children: [
                Expanded(flex:2,child: Image.asset(AssetsManager.book_doneIMG,
                width: 150.sp,
                  height: 150.sp,
                )),
                Text('${AppStringsManager.successfulBoking + '' + text}',style: getRegularStyle(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                    fontSize: 14.sp
                )),
                const SizedBox(height: AppSize.s10,),
                Text('سيتم الرد على طلبكم بالقبول او الرفض في اقرب وقت يرجى متابعة حالة الطلب في صفحة المواعيد',style: getRegularStyle(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                    fontSize: 12.sp
                ).copyWith(height: 1.5),),
                const SizedBox(height: AppSize.s10,),
                TextButton(
                  onPressed: (){
                    Get.back();
                  },
                  child: Text('موافق',style: getRegularStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12.sp
                  ),),
                ),
              ],
            ),
          ),
        ),
      )
  );

}
