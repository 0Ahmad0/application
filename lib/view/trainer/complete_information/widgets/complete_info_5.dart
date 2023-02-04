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

class CompleteInfo5 extends StatelessWidget {
  final PageController pageController;

  CompleteInfo5({super.key, required this.pageController});

  FilePickerResult? imageIDFile;
  FilePickerResult? carLicenceFile;
  FilePickerResult? carRegistrationFile;
  FilePickerResult? carImageFile;
  FilePickerResult? selfEmploymentLicenseFile;
  FilePickerResult? otherImageFile;

  @override
  Widget build(BuildContext context) {
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
                  file: imageIDFile, text: AppStringsManager.image_id),
              BuildUploadeFile(
                  file: carLicenceFile, text: AppStringsManager.car_license),
              BuildUploadeFile(
                  file: carRegistrationFile,
                  text: AppStringsManager.car_registration),
              BuildUploadeFile(
                  file: carImageFile, text: AppStringsManager.car_image),
              BuildUploadeFile(
                  file: selfEmploymentLicenseFile,
                  text: AppStringsManager.self_employment_license),
              BuildUploadeFile(
                  file: otherImageFile, text: AppStringsManager.other_image),
            ],
          ),
        ),
        ButtonApp(
            text: AppStringsManager.send_request,
            onPressed: () {
              print(imageIDFile);
              print('**');
              print(carLicenceFile);
              print('**');
              print(carRegistrationFile);
              print('**');
              print(carImageFile);
              print('**');
              print(selfEmploymentLicenseFile);
              print('**');
              print(otherImageFile);
              if ((imageIDFile == null) ||
                  (carLicenceFile == null) ||
                  (carRegistrationFile == null) ||
                  (carImageFile == null) ||
                  (selfEmploymentLicenseFile == null) ||
                  (otherImageFile == null)) {

                Get.snackbar(AppStringsManager.error,
                    AppStringsManager.please_uploade_all_images);
              } else {
                Const.TOAST(context, textToast: 'Sucess');
              }
            }),
      ],
    );
  }

}

class BuildUploadeFile extends StatefulWidget {
  FilePickerResult? file;
  final String text;

  BuildUploadeFile({super.key, required this.file, required this.text});

  @override
  State<BuildUploadeFile> createState() => _BuildUploadeFileState();
}

class _BuildUploadeFileState extends State<BuildUploadeFile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: AppSize.s12,
        ),
        InkWell(
          onTap: () async {
            widget.file = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf', 'doc', 'png', 'jpg', 'jpeg'],
            );
            if (widget.file != null) {
              setState(() {});
              print(widget.file!.files.first.name);
              print(widget.file!.files.first.size);
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
              (widget.file != null)
                  ? widget.file!.files.first.name
                  : AppStringsManager.uploade_image,
              style: getRegularStyle(
                  color: ColorManager.hintColor, fontSize: 10.sp),
            ),
            widget.file != null
                ? IconButton(
                    onPressed: () {
                      widget.file = null;
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
