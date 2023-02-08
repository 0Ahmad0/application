import 'dart:io';
import '../../../controller/auth_controller.dart';
import '../../../controller/provider/profile_provider.dart';
import '../../../model/utils/const.dart';
import '/view/edit_password/edit_passord_view.dart';
import '/view/resourse/style_manager.dart';
import '../../resourse/string_manager.dart';
import 'package:flutter/material.dart';
import '../../login/login_view.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/values_manager.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../manager/widgets/button_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/color_manager.dart';
class EditPasswordViewBody extends StatelessWidget {
   EditPasswordViewBody({Key? key, required this.authController, required this.profileProvider}) : super(key: key);
   final AuthController authController;
   final ProfileProvider profileProvider;
final nowPasswordController = TextEditingController();
final newPasswordController = TextEditingController();
final confirmNewPasswordController = TextEditingController();
   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p10, horizontal: AppPadding.p16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppSize.s20,),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      AppStringsManager.now_password,
                      style: getRegularStyle(
                          color: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .color,
                          fontSize: 12.sp),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFiledApp(
                      controller: nowPasswordController,
                      hintText:
                          AppStringsManager.now_password,
                      obscureText: true,
                      suffixIcon: true,
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Text(
                      AppStringsManager.new_password,
                      style: getRegularStyle(
                          color: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .color,
                          fontSize: 12.sp),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFiledApp(
                      controller: newPasswordController,
                      hintText:
                          AppStringsManager.new_password,
                      obscureText: true,
                      suffixIcon: true,                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Text(
                      AppStringsManager.new_password,
                      style: getRegularStyle(
                          color: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .color,
                          fontSize: 12.sp),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFiledApp(
                      controller: confirmNewPasswordController,
                      hintText:
                          AppStringsManager.confirm_new_password,
                      obscureText: true,
                      suffixIcon: true,
                    ),
                    const SizedBox(height: AppSize.s10,),


                  ],
                ),
              ),
              ButtonApp(
                  color: ColorManager.thirdlyColor,
                  text: AppStringsManager.save, onPressed: () async {
                if(formKey.currentState!.validate()){
                  if(profileProvider.user.password==nowPasswordController.text){
                    if(profileProvider.user.password!=newPasswordController.text) {
                      Const.LOADIG(context);
                      profileProvider.user.password =
                          newPasswordController.text;
                      final result = await authController.authProvider
                          .recoveryPassword(
                          context, user: profileProvider.user);
                      Get.back();
                      Get.back();
                    }else{
                    Get.snackbar(AppStringsManager.error, AppStringsManager.match_now_password);
                  }
                  }else{
                    Get.snackbar(AppStringsManager.error, AppStringsManager.fault_now_password);
                  }
                }else{
                  Get.snackbar(AppStringsManager.error, AppStringsManager.no_match_new_password);
                }
              }),

            ],
          ),
        ));
  }
}
