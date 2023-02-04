import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/string_manager.dart';
import '/view/resourse/style_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/utils/const.dart';
import '../../../manager/const.dart';
import '../../../manager/widgets/button_app.dart';
import '../../../manager/widgets/linear_progress.dart';

class CompleteInfo3 extends StatelessWidget {
  final idLicenceCarController = TextEditingController();
  var haveCar = '';
  var trainedFemaleStudents = '';
  var workInDrivingSchools = '';
  final GlobalKey<FormState> formKey;
  final PageController pageController;
  CompleteInfo3({super.key, required this.formKey, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LinearProgress(
            minHeight: 2.5,
            currentStep: 3,
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
                const Text(AppStringsManager.driver_license_number,),
                const SizedBox(height: AppSize.s10,),
                TextFiledApp(
                  controller: idLicenceCarController,
                  hintText: AppStringsManager.driver_license_number,
                ),
                const SizedBox(height: AppSize.s30,),
                const Text(AppStringsManager.do_you_have_car,),
                const SizedBox(height: AppSize.s10,),
                DropdownButtonFormField(
                  icon: const Icon(Icons.keyboard_arrow_down),
                    validator: ( value){
                      if(value == null){
                        return AppStringsManager.field_required;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: AppStringsManager.yes,
                      hintStyle: getRegularStyle(
                        color: ColorManager.hintColor,
                        fontSize: 12.sp
                      )
                    ),
                    items: [
                      for(int i = 0 ; i < ConstApp.answer.length;i++)
                        DropdownMenuItem(
                          child: Text(ConstApp.answer[i]),
                          value: ConstApp.answer[i],
                        )
                    ], onChanged: (value){
                      haveCar = value.toString();
                }),
                const SizedBox(height: AppSize.s30,),
                const Text(AppStringsManager.have_you_ever_trained_female_students,),
                const SizedBox(height: AppSize.s10,),
                DropdownButtonFormField(
                    icon: const Icon(Icons.keyboard_arrow_down),

                    validator: ( value){
                      if(value == null){
                        return AppStringsManager.field_required;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: AppStringsManager.yes,
                        hintStyle: getRegularStyle(
                            color: ColorManager.hintColor,
                            fontSize: 12.sp
                        )
                    ),
                    items: [
                      for(int i = 0 ; i < ConstApp.answer.length;i++)
                        DropdownMenuItem(
                          child: Text(ConstApp.answer[i]),
                          value: ConstApp.answer[i],
                        )
                    ], onChanged: (value){
                  trainedFemaleStudents = value.toString();
                }),
                const SizedBox(height: AppSize.s30,),
                const Text(AppStringsManager.did_you_work_in_driving_schools,),
                const SizedBox(height: AppSize.s10,),
                DropdownButtonFormField(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    validator: ( value){
                      if(value == null){
                        return AppStringsManager.field_required;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: AppStringsManager.yes,
                        hintStyle: getRegularStyle(
                            color: ColorManager.hintColor,
                            fontSize: 12.sp
                        )
                    ),
                    items: [
                      for(int i = 0 ; i < ConstApp.answer.length;i++)
                        DropdownMenuItem(
                          child: Text(ConstApp.answer[i]),
                          value: ConstApp.answer[i],
                        )
                    ], onChanged: (value){
                  workInDrivingSchools = value.toString();
                }),
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

