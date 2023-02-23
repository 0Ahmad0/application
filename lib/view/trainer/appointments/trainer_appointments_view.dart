import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/controller/date_trainer_controller.dart';
import 'package:pinkey/model/models.dart';
import 'package:pinkey/view/trainer/add_course_time/add_course_time_view.dart';
import 'package:pinkey/view/trainer/add_new_course/add_new_course_view.dart';

import '../../../controller/course_controller.dart';
import 'widgets/trainer_appointments_view_body.dart';

class TrainerAppointmentsView extends StatelessWidget {
  const TrainerAppointmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    CourseController courseController= CourseController(context: context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          courseController.courseProvider.course=Course.init();
          Get.to(()=>AddNewCourseView(add: true,),transition: Transition.leftToRightWithFade);
        },
      ),
      body: TrainerAppointmentsViewBody(),
    );
  }
}
