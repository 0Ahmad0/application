import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';

Widget buildContainerDetailsTrainer({icon, text}) {
  return Expanded(
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p8,
        horizontal: AppPadding.p4
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: ColorManager.lightGray.withOpacity(.15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          FittedBox(
            child:  Text(
              text,
              style: getRegularStyle(color: ColorManager.black, fontSize: 8.sp),
            ),
          )

        ],
      ),
    ),
  );
}
