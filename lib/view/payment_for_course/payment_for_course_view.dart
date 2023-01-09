import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/string_manager.dart';

import '../resourse/color_manager.dart';
import 'widgets/payment_for_course_view_body.dart';

class PaymentForCourseView extends StatelessWidget {
  const PaymentForCourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStringsManager.payment_for_course),
        leading: BackButton(color: ColorManager.black,),
      ),
      body: PaymentForCourseViewBody(),
    );
  }
}
