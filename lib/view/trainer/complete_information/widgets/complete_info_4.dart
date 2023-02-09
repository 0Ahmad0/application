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

import '../../../../controller/provider/auth_provider.dart';
import '../../../../model/utils/const.dart';
import '../../../manager/widgets/button_app.dart';
import '../../../manager/widgets/linear_progress.dart';

class CompleteInfo4 extends StatelessWidget {
  var numberOfHourController = TextEditingController();
  var priceInYourCarController = TextEditingController();
  var priceInHerCarController = TextEditingController();
  final GlobalKey<FormState> formKey;
  final PageController pageController;

  final AuthProvider authProvider;

  CompleteInfo4({super.key, required this.formKey, required this.pageController, required this.authProvider}){
  numberOfHourController = TextEditingController(text:authProvider.user.trainerInfo?.numberOfHour);
   priceInYourCarController = TextEditingController(text:authProvider.user.trainerInfo?.priceInYourCar);
   priceInHerCarController = TextEditingController(text:authProvider.user.trainerInfo?.priceInHerCar);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LinearProgress(
            minHeight: 2.5,
            currentStep: 4,
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
                const SizedBox(height: AppSize.s20,),
                const Text(AppStringsManager.expected_training_hours),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFiledApp(
                  controller: numberOfHourController,
                  hintText: AppStringsManager.number_of_hours,
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                const Text(AppStringsManager.price_in_your_personal_car),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFiledApp(
                  controller: priceInYourCarController,
                  hintText: AppStringsManager.price,
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),

                const Text(AppStringsManager.price_in_the_trainees_car),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFiledApp(
                  controller: priceInHerCarController,
                  hintText: AppStringsManager.price,
                ),


                const SizedBox(height: AppSize.s20,),

              ],
            ),
          ),
          ButtonApp(text: AppStringsManager.next, onPressed: (){
            if(formKey.currentState!.validate()){
              Const.LOADIG(context);
              authProvider.user.trainerInfo?.numberOfHour=numberOfHourController.text;
              authProvider.user.trainerInfo?.priceInYourCar=priceInYourCarController.text;
              authProvider.user.trainerInfo?.priceInHerCar=priceInHerCarController.text;
             Get.back();
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

