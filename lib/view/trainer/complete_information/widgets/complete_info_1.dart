import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class CompleteInfo1 extends StatelessWidget {
  final bornDateController = TextEditingController();
  final nationalityController = TextEditingController();
  final idNumberController = TextEditingController();
  var cityController = '';
  var neighborhoodController = '';
  final GlobalKey<FormState> formKey;
  final PageController pageController;


  CompleteInfo1({super.key, required this.formKey, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LinearProgress(
            minHeight: 2.5,
            currentStep: 1,
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorManager.borderColor,
                      radius: 12.w,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/1.png',
                          width: 24.w,
                          height: 24.w,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0.0,
                        left: 30.w,
                        child: InkWell(
                          onTap: () async {
                            ImagePicker imagePicker = new ImagePicker();
                            var image = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                          },
                          child: CircleAvatar(
                            backgroundColor: ColorManager.borderColor,
                            child: SvgPicture.asset(AssetsManager.edit_imageIMG),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                const Text(AppStringsManager.born_date),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.trim().isEmpty){
                      return AppStringsManager.field_required;
                    }
                  },
                  controller: bornDateController,
                  readOnly: true,
                  onTap: (){
                    Const.SelectDate(context: context, controller: bornDateController);
                  },
                  decoration: InputDecoration(
                      hintText: AppStringsManager.born_date,
                      hintStyle: getRegularStyle(color: ColorManager.hintColor,
                          fontSize: 12.sp
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        child: SvgPicture.asset(
                          AssetsManager.appointmentsIMG,
                        ),
                      )),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                const Text(AppStringsManager.nationality),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFiledApp(
                  controller: nationalityController,
                  hintText: AppStringsManager.nationality,
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Row(
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(AppStringsManager.city),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        DropdownButtonFormField(
                            icon:const Icon(Icons.keyboard_arrow_down),
                            validator: (value){
                              if(value == null){
                                return AppStringsManager.filed_Required;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: AppStringsManager.city,
                                hintStyle: getRegularStyle(
                                    color: ColorManager.hintColor,
                                    fontSize: 12.sp
                                )
                            ),
                            items: [
                              for(int i =0 ; i < 5 ; i++)
                                DropdownMenuItem(
                                  child: Text('city ${i}'),
                                  value: i,
                                )
                            ], onChanged: (value){
                          cityController = value.toString();
                          print(cityController);
                        }),
                      ],
                    )),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(AppStringsManager.neighborhood),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        DropdownButtonFormField(
                            icon:const Icon(Icons.keyboard_arrow_down),
                            validator: (value){
                              if(value == null){
                                return AppStringsManager.filed_Required;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: AppStringsManager.neighborhood,
                                hintStyle: getRegularStyle(
                                    color: ColorManager.hintColor,
                                    fontSize: 12.sp
                                )
                            ),
                            items: [
                              for(int i =0 ; i < 5 ; i++)
                                DropdownMenuItem(
                                  child: Text('neighborhood ${i}'),
                                  value: i,
                                )
                            ], onChanged: (value){
                          cityController = value.toString();
                          print(cityController);
                        }),
                      ],
                    )),

                  ],
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                const Text(AppStringsManager.id_number),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFiledApp(
                  controller: idNumberController,
                  hintText: AppStringsManager.id_number,
                  validator: (String? value){
                    if(value!.trim().isEmpty){
                      return AppStringsManager.field_required;
                    }else if(value.length < 12){
                      return AppStringsManager.enter_valid_id;
                    }
                  },
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

