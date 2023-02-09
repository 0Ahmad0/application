import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinkey/controller/auth_controller.dart';
import 'package:pinkey/model/utils/consts_manager.dart';
import 'package:pinkey/view/login/login_view.dart';
import 'package:pinkey/view/manager/widgets/textformfiled_app.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:pinkey/view/welcome/welcome_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../controller/provider/complete_info_5_provider.dart';
import '../../../../model/utils/const.dart';
import '../../../manager/widgets/button_app.dart';
import '../../../manager/widgets/linear_progress.dart';

class CompleteInfo5 extends StatelessWidget {
  final PageController pageController;

  CompleteInfo5({super.key, required this.pageController, required this.authController});

  // FilePickerResult? imageIDFile;
  // FilePickerResult? carLicenceFile;
  // FilePickerResult? carRegistrationFile;
  // FilePickerResult? carImageFile;
  // FilePickerResult? selfEmploymentLicenseFile;
  // FilePickerResult? otherImageFile;
  late CompleteInfo5Provider completeInfo5Provider;
  final AuthController authController;
  @override
  Widget build(BuildContext context) {
    completeInfo5Provider= Provider.of<CompleteInfo5Provider>(context);
    return Column(
      children: [
        LinearProgress(
          minHeight: 2.5,
          currentStep: 5,
          maxSteps: 5,
        ),
        Expanded(
          child: ListView(
            children: [
              Row(
                children: [
                  BackButton(
                    color: ColorManager.black,
                    onPressed: () {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                  ),
                ],
              ),
              Text.rich(TextSpan(children: [
                const TextSpan(
                    text: AppStringsManager.complete_your_info + ' '),
                TextSpan(
                    text: AppStringsManager.complete_your_personal_info,
                    style: getRegularStyle(color: ColorManager.hintColor)),
              ])),
              const SizedBox(
                height: AppSize.s10,
              ),
              Text(
                AppStringsManager.should_be_complete_your_info_for_accepting,
                style: getRegularStyle(
                    color: ColorManager.hintColor, fontSize: 12.sp),
              ),
              BuildUploadeFile(
                  file: completeInfo5Provider.imageIDFile, text: AppStringsManager.image_id),
              BuildUploadeFile(
                  file: completeInfo5Provider.carLicenceFile, text: AppStringsManager.car_license),
              BuildUploadeFile(
                  file: completeInfo5Provider.carRegistrationFile,
                  text: AppStringsManager.car_registration),
              BuildUploadeFile(
                  file: completeInfo5Provider.carImageFile, text: AppStringsManager.car_image),
              BuildUploadeFile(
                  file: completeInfo5Provider.selfEmploymentLicenseFile,
                  text: AppStringsManager.self_employment_license),
              BuildUploadeFile(
                  file: completeInfo5Provider.otherImageFile, text: AppStringsManager.other_image),
            ],
          ),
        ),
        ButtonApp(
            text: AppStringsManager.send_request,
            onPressed: () async {
              print(completeInfo5Provider.imageIDFile);
              print('**');
              print(completeInfo5Provider.carLicenceFile);
              print('**');
              print(completeInfo5Provider.carRegistrationFile);
              print('**');
              print(completeInfo5Provider.carImageFile);
              print('**');
              print(completeInfo5Provider.selfEmploymentLicenseFile);
              print('**');
              print(completeInfo5Provider.otherImageFile);
              if ((completeInfo5Provider.files[completeInfo5Provider.imageIDFile] == null) ||
                  (completeInfo5Provider.files[completeInfo5Provider.carLicenceFile] == null) ||
                  (completeInfo5Provider.files[completeInfo5Provider.carRegistrationFile] == null) ||
                  (completeInfo5Provider.files[completeInfo5Provider.carImageFile] == null) ||
                  (completeInfo5Provider.files[completeInfo5Provider.selfEmploymentLicenseFile] == null) ||
                  (completeInfo5Provider.files[completeInfo5Provider.otherImageFile ]== null)) {

                Get.snackbar(AppStringsManager.error,
                    AppStringsManager.please_uploade_all_images);
              } else {
                Const.LOADIG(context);
                authController.authProvider.user.trainerInfo?.imageIDFileUrl=await  authController.authProvider.uploadFile(context, File('${completeInfo5Provider.files[completeInfo5Provider.imageIDFile]?.files.first.path}'),folder:AppConstants.collectionTrainer);
                authController.authProvider.user.trainerInfo?.carLicenceFileUrl=await  authController.authProvider.uploadFile(context, File('${completeInfo5Provider.files[completeInfo5Provider.carLicenceFile]?.files.first.path}'),folder:AppConstants.collectionTrainer);
                authController.authProvider.user.trainerInfo?.carRegistrationFileUrl=await  authController.authProvider.uploadFile(context, File('${completeInfo5Provider.files[completeInfo5Provider.carRegistrationFile]?.files.first.path}'),folder:AppConstants.collectionTrainer);
                authController.authProvider.user.trainerInfo?.carImageFileUrl=await  authController.authProvider.uploadFile(context, File('${completeInfo5Provider.files[completeInfo5Provider.carImageFile]?.files.first.path}'),folder:AppConstants.collectionTrainer);
                authController.authProvider.user.trainerInfo?.selfEmploymentLicenseFileUrl=await  authController.authProvider.uploadFile(context, File('${completeInfo5Provider.files[completeInfo5Provider.selfEmploymentLicenseFile]?.files.first.path}'),folder:AppConstants.collectionTrainer);
                authController.authProvider.user.trainerInfo?.otherImageFileUrl=await  authController.authProvider.uploadFile(context, File('${completeInfo5Provider.files[completeInfo5Provider.otherImageFile]?.files.first.path}'),folder:AppConstants.collectionTrainer);
                Get.back();
                var result =await authController.signUpByUser(context);

                if(result['status']){

                  Get.off(()=>WelcomeView());
                }




              }
            }),
      ],
    );
  }

}

class BuildUploadeFile extends StatefulWidget {
  String file;
  final String text;

  BuildUploadeFile({super.key, required this.file, required this.text});

  @override
  State<BuildUploadeFile> createState() => _BuildUploadeFileState();
}

class _BuildUploadeFileState extends State<BuildUploadeFile> {
  @override
  Widget build(BuildContext context) {
    final CompleteInfo5Provider completeInfo5Provider= Provider.of<CompleteInfo5Provider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: AppSize.s12,
        ),
        InkWell(
          onTap: () async {
            completeInfo5Provider.files[widget.file] = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf', 'doc', 'png', 'jpg', 'jpeg'],
            );
            if (completeInfo5Provider.files[widget.file] != null) {
              setState(() {});
              print(completeInfo5Provider.files[widget.file]!.files.first.name);
              print(completeInfo5Provider.files[widget.file]!.files.first.size);
            } else {
              Get.snackbar(
                  AppStringsManager.error, AppStringsManager.please_uploade_cv,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.zero,
                  borderRadius: 0.0);
            }
          },
          child: Row(
            children: [
              Text(
                widget.text,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Row(
          children: [
            Text(
              (completeInfo5Provider.files[widget.file] != null)
                  ? completeInfo5Provider.files[widget.file]!.files.first.name
                  : AppStringsManager.uploade_image,
              style: getRegularStyle(
                  color: ColorManager.hintColor, fontSize: 10.sp),
            ),
            completeInfo5Provider.files[widget.file] != null
                ? IconButton(
                    onPressed: () {
                      completeInfo5Provider.files[widget.file] = null;
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.error,
                    ))
                : SizedBox(),
          ],
        )
      ],
    );
  }
}
