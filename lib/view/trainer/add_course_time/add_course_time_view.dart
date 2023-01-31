import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';

import 'widgets/add_course_time_view_body.dart';

class AddCourseTimeView extends StatelessWidget {
  const AddCourseTimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: ColorManager.black,),
        title: Text(AppStringsManager.add_course_time),
      ),
      body: AddCourseTimeViewBody(),
    );
  }
}
