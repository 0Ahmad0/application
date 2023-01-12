import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinkey/view/manager/widgets/textformfiled_app.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../model/utils/const.dart';
import '../../../manager/widgets/button_app.dart';
import '../../../manager/widgets/linear_progress.dart';

class CompleteInfo2 extends StatelessWidget {
  final aboutForYouController = TextEditingController();
  final GlobalKey<FormState> formKey;
  final PageController pageController;

  CompleteInfo2({super.key, required this.formKey, required this.pageController});
  File? file;
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LinearProgress(
            minHeight: 2.5,
            currentStep: 2,
            maxSteps: 5,
          ),
          Expanded(
            child: ListView(
              children: [

                Row(
                  children:  [
                    BackButton(color: ColorManager.black,onPressed: (){
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },),
                  ],
                ),
                Text.rich(
                    TextSpan(
                        children: [
                          const TextSpan(
                              text: AppStringsManager.complete_your_info + ' '),
                          TextSpan(
                              text: AppStringsManager.complete_your_personal_info
                              , style: getRegularStyle(
                              color: ColorManager.hintColor
                          )),
                        ]
                    )
                ),
                const SizedBox(height: AppSize.s10,),
                Text(AppStringsManager.should_be_complete_your_info_for_accepting,
                  style: getRegularStyle(color: ColorManager.hintColor,
                      fontSize: 12.sp),
                ),
                const SizedBox(height: AppSize.s10,),
                const Text(AppStringsManager.about_for_you,),
                const SizedBox(height: AppSize.s10,),
                TextFiledApp(
                  controller: aboutForYouController,
                  hintText: AppStringsManager.about_for_you,
                  minline: 8,
                  maxline: 10,

                ),
                const SizedBox(height: AppSize.s40,),
                 InkWell(
                   onTap: ()async{
                      result = await FilePicker.platform.pickFiles(
                       type: FileType.custom,
                       allowedExtensions: ['pdf','doc','png','jpg','jpeg'],
                     );
                     if (result != null) {
                        file = File(result!.files.first.path!);
                     } else {
                       Get.snackbar(
                           AppStringsManager.error,
                           AppStringsManager.please_uploade_cv,
                         snackPosition: SnackPosition.BOTTOM,
                         margin: EdgeInsets.zero,
                         borderRadius: 0.0
                       );
                     }
                   },
                   child: Row(
                     children: [
                       Text(AppStringsManager.uploade_your_cv,),
                     ],
                   ),
                 ),
                const SizedBox(height: AppSize.s10,),
                Visibility(
                  visible: true ,
                  child: Chip(
                    onDeleted: (){},
                    label: Text('result == null ? "":result!.files.first.name'),
                  ),
                ),
                const SizedBox(height: AppSize.s20,),

              ],
            ),
          ),
          ButtonApp(text: AppStringsManager.next, onPressed: (){
            if(!formKey.currentState!.validate()){
              pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            }
          }),

        ],
      ),
    );
  }

}

