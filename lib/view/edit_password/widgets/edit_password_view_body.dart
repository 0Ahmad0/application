import 'dart:io';
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
import '/translations/locale_keys.g.dart';
import '/view/resourse/color_manager.dart';
class EditPasswordViewBody extends StatelessWidget {
   EditPasswordViewBody({Key? key}) : super(key: key);
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
                  text: AppStringsManager.save, onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('yes');
                }
              }),

            ],
          ),
        ));
  }
}
