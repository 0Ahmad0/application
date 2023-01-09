import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';

import 'widgets/complaint_view_body.dart';

class ComplaintView extends StatelessWidget {
  const ComplaintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStringsManager.complaint),
        leading: const BackButton(color: ColorManager.black,),
      ),
      body: ComplaintViewBody(),
    );
  }
}
