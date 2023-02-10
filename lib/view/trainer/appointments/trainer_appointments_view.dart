import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/view/trainer/add_course_time/add_course_time_view.dart';
import 'package:pinkey/view/trainer/add_new_course/add_new_course_view.dart';

import 'widgets/trainer_appointments_view_body.dart';

class TrainerAppointmentsView extends StatelessWidget {
  const TrainerAppointmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          Get.to(()=>AddCourseTimeView(),transition: Transition.leftToRightWithFade);
        },
      ),
      body: TrainerAppointmentsViewBody(),
    );
  }
}
