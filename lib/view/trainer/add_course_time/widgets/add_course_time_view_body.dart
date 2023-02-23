import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/controller/date_trainer_controller.dart';
import 'package:pinkey/model/models.dart';
import 'package:pinkey/model/utils/const.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import '../../../../controller/course_controller.dart';
import '../../../app/app_uses.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/string_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';
import '/view/trainer/add_course_time/add_course_time_view.dart';
class AddCourseTimeViewBody extends StatelessWidget {
   AddCourseTimeViewBody({Key? key,required this.courseController,  required this.add}):super(key: key) {
     courseDateController = TextEditingController(text: DateFormat.yMd().format(courseController.courseProvider.course.dateTime));


   }
   final bool add;
   final CourseController courseController;
  final _formKey = GlobalKey<FormState>();
  var courseDateController = TextEditingController();
   var courseDayController = TextEditingController();
   var courseFromController = TextEditingController();
   var courseToController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    courseDayController = TextEditingController(text: DateFormat('','ar').add_EEEE().format(courseController.courseProvider.course.dateTime));
    if(!add){
      courseFromController = TextEditingController(text :courseController.courseProvider.course.from!.format(context));
      courseToController = TextEditingController(text :courseController.courseProvider.course.to!.format(context));
    }

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text(AppStringsManager.add_course_date),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  TextFiledApp(
                    onTap: ()async{
                      AppUsuallyUsed.selectDate(context, courseDateController);
                    },
                    readOnly: true,
                    controller: courseDateController,
                    hintText: DateFormat().add_yMd().format(DateTime.now()),
                  ),
                  // const SizedBox(
                  //   height: AppSize.s20,
                  // ),
                  // const Text(AppStringsManager.add_course_day),
                  // const SizedBox(
                  //   height: AppSize.s10,
                  // ),
                  // DropdownButtonFormField(
                  //   icon: Icon(Icons.keyboard_arrow_down),
                  //   items: [
                  //  for(int i = 0 ; i < _listDays.length ; i++)
                  //    DropdownMenuItem(
                  //      child: Text(_listDays[i]),
                  //      value: _listDays[i],
                  //    )
                  // ], onChanged: (val){
                  //   courseDayController.text = val.toString();
                  // },
                  //   validator: (val){
                  //   if(val == null){
                  //     return AppStringsManager.field_required;
                  //   }
                  //   },
                  // decoration: InputDecoration(
                  //   hintText: _listDays[0],
                  //   hintStyle: getRegularStyle(
                  //     color: ColorManager.hintColor,
                  //     fontSize: 12.sp
                  //   )
                  // ),
                  // ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  const Text(AppStringsManager.add_course_time_from_to),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFiledApp(
                            readOnly: true,
                        onTap: ()async{
                          AppUsuallyUsed.selectTime(context, courseFromController);
                        },
                        controller: courseFromController,
                        hintText: AppStringsManager.from,
                      )),
                      const SizedBox(width: AppSize.s12),
                      Expanded(
                          child: TextFiledApp(
                            readOnly: true,
                            onTap: ()async{
                              AppUsuallyUsed.selectTime(context, courseToController);
                            },
                        controller: courseToController,
                        hintText: AppStringsManager.to,
                      )),
                    ],
                  ),


                ],
              ),

            ),
            ButtonApp(
                text: AppStringsManager.publication_course,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    courseController.courseProvider.course.dateTime=DateFormat.yMd().parse(courseDateController.text);
                    courseController.courseProvider.course.from=courseController.stringToTimeOfDay(courseFromController.text);
                    courseController.courseProvider.course.to=courseController.stringToTimeOfDay(courseToController.text);
                    //print(DateTrainer.fromJson(dateTrainerController.dateTrainerProvider.dateTrainer.toJson()).from);
                    if(!add)
                    await courseController.updateCourse(context, course: courseController.courseProvider.course);
                        else
                    await courseController.addCourse(context, course: courseController.courseProvider.course);
                  }
                })
          ],
        ),
      ),
    );
  }
  final List _listDays = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
  ];
}
