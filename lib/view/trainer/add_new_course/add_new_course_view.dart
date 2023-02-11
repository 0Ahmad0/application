import 'package:flutter/material.dart';
import 'package:pinkey/controller/course_controller.dart';
import '../../../controller/date_trainer_controller.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/string_manager.dart';

import 'widgets/add_new_course_view_body.dart';

class AddNewCourseView extends StatelessWidget {
  const AddNewCourseView({Key? key, required this.add}) : super(key: key);
  final bool add;
  @override
  Widget build(BuildContext context) {
CourseController courseController=CourseController(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStringsManager.add_new_course),
        leading: BackButton(color: ColorManager.black,),
      ),
      body: AddNewCourseViewBody(add:add,courseController:courseController),
    );
  }
}
