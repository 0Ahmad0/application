import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';
import '../../login/login_view.dart';

import '../../resourse/const_manager.dart';
import '../../resourse/string_manager.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/values_manager.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: ConstManager.logoDelay), () => Get.off(() => LoginView()));
    return FadeInLeftBig(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsManager.splashIMG),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(AssetsManager.logoIMG),
            const SizedBox(height: AppSize.s10,),
            Text(AppStringsManager.splashText,style: getRegularStyle(
              color: ColorManager.white,
              fontSize: 16.sp
            ),),
            const Spacer(),
            SizedBox(
              width: 10.w,
              height: 10.h,
              child: LoadingIndicator(
                  indicatorType: Indicator.lineSpinFadeLoader, /// Required, The loading type of the widget
                  colors: const [Colors.white],       /// Optional, The color collections
                  strokeWidth: .5,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                  backgroundColor: Colors.transparent,      /// Optional, Background of the widget
                  pathBackgroundColor: ColorManager.lightGray   /// Optional, the stroke backgroundColor
              ),
            )

          ],
        ),
      ),
    );
  }
}
