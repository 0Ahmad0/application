import 'package:flutter/material.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/string_manager.dart';

import 'widgets/add_new_course_view_body.dart';

class AddNewCourseView extends StatelessWidget {
  const AddNewCourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStringsManager.add_new_course),
        leading: BackButton(color: ColorManager.black,),
      ),
      body: AddNewCourseViewBody(),
    );
  }
}
