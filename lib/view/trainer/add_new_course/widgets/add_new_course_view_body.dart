import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/controller/course_controller.dart';
import '../../../../controller/date_trainer_controller.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/string_manager.dart';
import '/view/resourse/values_manager.dart';
import '/view/trainer/add_course_time/add_course_time_view.dart';

class AddNewCourseViewBody extends StatelessWidget {
  AddNewCourseViewBody({Key? key, required this.add, required this.courseController}) : super(key: key){
    courseCategoryController = TextEditingController(text:courseController.courseProvider.course.category);
     courseNameController = TextEditingController(text:courseController.courseProvider.course.name);
     if(!add){
       courseDurationController = TextEditingController(text:'${courseController.courseProvider.course.durationInDays}');
       courseDurationInDaysController = TextEditingController(text:'${courseController.courseProvider.course.durationInDays}');
       coursePriceController = TextEditingController();
       coursePriceInTrainerCarController = TextEditingController(text:'${courseController.courseProvider.course.priceInTrainerCar}');
       coursePriceInPersonalCarController = TextEditingController(text:'${courseController.courseProvider.course.priceInPersonalCar}');
     }

     courseDescriptionController = TextEditingController(text:courseController.courseProvider.course.description);
  }
  final CourseController courseController;
  final bool add;
  var _formKey = GlobalKey<FormState>();
  var courseCategoryController = TextEditingController();
  var courseNameController = TextEditingController();
  var courseDurationController = TextEditingController();
  var courseDurationInDaysController = TextEditingController();
  var coursePriceController = TextEditingController();
  var coursePriceInTrainerCarController = TextEditingController();
  var coursePriceInPersonalCarController = TextEditingController();
  var courseDescriptionController = TextEditingController();

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
          ButtonApp(text: AppStringsManager.next, onPressed: (){
            if(_formKey.currentState!.validate()){

              courseController.courseProvider.course.category=courseCategoryController.text;
              courseController.courseProvider.course.priceInPersonalCar=num.parse(coursePriceInPersonalCarController.text);
              courseController.courseProvider.course.priceInTrainerCar=num.parse(coursePriceInTrainerCarController.text);
              courseController.courseProvider.course.durationInDays=num.parse(courseDurationController.text);
              courseController.courseProvider.course.description=courseDescriptionController.text;
              courseController.courseProvider.course.name=courseNameController.text;

              Get.to(()=>AddCourseTimeView(add: add,),transition: Transition.upToDown);
            }
          })
        ],
      ),
    );
  }
}
