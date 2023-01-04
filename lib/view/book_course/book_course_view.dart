import 'package:flutter/material.dart';

import 'widgets/book_course_view_body.dart';

class BookCourseView extends StatelessWidget {
  const BookCourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text("حجز دورة تدريبية"),
      ),
      body: BookCourseViewBody(),
    );
  }
}
