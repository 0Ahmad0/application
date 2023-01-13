import 'package:flutter/material.dart';
import 'package:pinkey/view/manager/widgets/button_app.dart';
import 'package:pinkey/view/manager/widgets/textformfiled_app.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';

class AddNewCourseViewBody extends StatelessWidget {
  AddNewCourseViewBody({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final courseCategoryController = TextEditingController();
  final courseNameController = TextEditingController();
  final courseDurationController = TextEditingController();
  final courseDurationInDaysController = TextEditingController();
  final coursePriceController = TextEditingController();
  final coursePriceInTrainerCarController = TextEditingController();
  final coursePriceInPersonalCarController = TextEditingController();
  final courseDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p16),

        children: [
          const Text(AppStringsManager.course_category),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            controller: courseCategoryController,
            hintText: AppStringsManager.course_category,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          const Text(AppStringsManager.course_name),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            controller: courseNameController,
            hintText: AppStringsManager.course_name,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          const Text(AppStringsManager.course_duration),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            controller: courseDurationController,
            hintText: AppStringsManager.course_duration_in_days,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          const Text(AppStringsManager.course_price),
          const SizedBox(
            height: AppSize.s10,
          ),
          Row(
            children: [
              Expanded(
                  child: TextFiledApp(
                controller: coursePriceInTrainerCarController,
                hintText: AppStringsManager.course_price_in_trainer_car,
              )),
              const SizedBox(width: AppSize.s12),
              Expanded(
                  child: TextFiledApp(
                controller: coursePriceInPersonalCarController,
                hintText:
                    AppStringsManager.course_price_in_personal_car,
              )),
            ],
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          const Text(AppStringsManager.course_description),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            controller: courseDescriptionController,
            hintText: AppStringsManager.course_description,
            minline: 4,
            maxline: 6,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          ButtonApp(text: AppStringsManager.publication_course, onPressed: (){
            if(_formKey.currentState!.validate()){}
          })
        ],
      ),
    );
  }
}
