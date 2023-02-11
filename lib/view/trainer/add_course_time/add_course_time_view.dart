import 'package:flutter/material.dart';
import 'package:pinkey/controller/date_trainer_controller.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';

import '../../../controller/course_controller.dart';
import 'widgets/add_course_time_view_body.dart';

class AddCourseTimeView extends StatelessWidget {
  const AddCourseTimeView({Key? key,  required this.add}) : super(key: key);
  final bool add;
  @override
  Widget build(BuildContext context) {
    CourseController courseController= CourseController(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: ColorManager.black,),
        title: Text(AppStringsManager.add_course_time),
      ),
      body: AddCourseTimeViewBody(courseController:courseController,add: add,),
    );
  }
}
