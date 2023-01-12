import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:pinkey/view/manager/widgets/button_app.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../resourse/color_manager.dart';
import 'complete_info_1.dart';
import 'complete_info_2.dart';
import 'complete_info_3.dart';
import 'complete_info_4.dart';
import 'complete_info_5.dart';

class CompleteInformationViewBody extends StatefulWidget {
  const CompleteInformationViewBody({Key? key}) : super(key: key);

  @override
  State<CompleteInformationViewBody> createState() =>
      _CompleteInformationViewBodyState();
}

class _CompleteInformationViewBodyState
    extends State<CompleteInformationViewBody> {
  int _currentStep = 1;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            _currentStep = (index + 1);
            setState(() {

            });
          },
          children: [
            CompleteInfo1(formKey: _formKey1,pageController: _pageController,),
            CompleteInfo2(formKey: _formKey2,pageController: _pageController,),
            CompleteInfo3(formKey: _formKey3,pageController: _pageController,),
            CompleteInfo4(formKey: _formKey4,pageController: _pageController,),
            CompleteInfo5(),
          ],
        ),
      ),
    );
  }
}
