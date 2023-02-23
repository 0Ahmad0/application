import 'package:flutter/material.dart';

import '../../controller/book_course_controller.dart';
import 'widgets/appointments_view_body.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppointmentsViewBody(bookCourseController:BookCourseController(context: context)),
    );
  }
}
