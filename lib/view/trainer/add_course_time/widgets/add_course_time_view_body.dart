import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import '../../../app/app_uses.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/string_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';
import '/view/trainer/add_course_time/add_course_time_view.dart';
class AddCourseTimeViewBody extends StatelessWidget {
   AddCourseTimeViewBody({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final courseDateController = TextEditingController();
  final courseDayController = TextEditingController();
  final courseFromController = TextEditingController();
  final courseToController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text(AppStringsManager.add_course_date),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  TextFiledApp(
                    onTap: ()async{
                      AppUsuallyUsed.selectDate(context, courseDateController);
                    },
                    readOnly: true,
                    controller: courseDateController,
                    hintText: DateFormat().add_yMd().format(DateTime.now()),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  const Text(AppStringsManager.add_course_day),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  DropdownButtonFormField(
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: [
                   for(int i = 0 ; i < _listDays.length ; i++)
                     DropdownMenuItem(
                       child: Text(_listDays[i]),
                       value: _listDays[i],
                     )
                  ], onChanged: (val){
                    courseDayController.text = val.toString();
                  },
                    validator: (val){
                    if(val == null){
                      return AppStringsManager.field_required;
                    }
                    },
                  decoration: InputDecoration(
                    hintText: _listDays[0],
                    hintStyle: getRegularStyle(
                      color: ColorManager.hintColor,
                      fontSize: 12.sp
                    )
                  ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  const Text(AppStringsManager.add_course_time_from_to),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFiledApp(
                            readOnly: true,
                        onTap: ()async{
                          AppUsuallyUsed.selectTime(context, courseFromController);
                        },
                        controller: courseFromController,
                        hintText: AppStringsManager.from,
                      )),
                      const SizedBox(width: AppSize.s12),
                      Expanded(
                          child: TextFiledApp(
                            readOnly: true,
                            onTap: ()async{
                              AppUsuallyUsed.selectTime(context, courseToController);
                            },
                        controller: courseToController,
                        hintText: AppStringsManager.to,
                      )),
                    ],
                  ),


                ],
              ),

            ),
            ButtonApp(
                text: AppStringsManager.publication_course,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                  }
                })
          ],
        ),
      ),
    );
  }
  final List _listDays = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
  ];
}
