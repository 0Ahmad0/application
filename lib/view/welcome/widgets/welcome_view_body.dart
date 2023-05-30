import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/view/navbar/navbar.dart';
import 'package:pinkey/view/resourse/color_manager.dart';

import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/utils/create_environment_provider.dart';
import '../../../model/utils/consts_manager.dart';
import '../../login/login_view.dart';
import '../../manager/widgets/button_app.dart';
import '../../resourse/assets_manager.dart';
import '../../resourse/string_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';

class WelcomeViewBody extends StatelessWidget {
  WelcomeViewBody({Key? key, required this.authController}) : super(key: key);
  final AuthController authController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              child: Container(
                  width: 35.w,
                  height: 35.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorManager.primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p20),
                    child: Image.asset(AssetsManager.logoIMG),
                  )),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            ButtonApp(
                text: AppStringsManager.login,
                onPressed: () async {
                  //await CreateEnvironmentProvider().createAdmins(context);
                  authController.authProvider.text =
                      AppStringsManager.login_to_complete_book;
                  Get.to(() => LoginView());
                }),
            // const SizedBox(height: AppSize.s10,),
            // ButtonApp(text: AppStringsManager.login_admin, onPressed: () async {
            //   //await CreateEnvironmentProvider().createAdmins(context);
            //   authController.authProvider.text=AppStringsManager.login_to_managment_account;
            //     Get.to(()=>LoginView());
            // }),
            const SizedBox(
              height: AppSize.s10,
            ),
            ButtonApp(
                text: AppStringsManager.login_visit,
                onPressed: () async {
                  await authController.visitor();
                }),
          ],
        ),
      ),
    );
  }

  GestureDetector buildWelcomeButton(BuildContext context, {text, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppPadding.p20),
          margin: const EdgeInsets.all(AppMargin.m12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(AppSize.s50)),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          )),
    );
  }
}
