import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/controller/provider/report_provider.dart';
import 'package:pinkey/model/utils/const.dart';
import 'package:pinkey/view/complaint/widgets/all_complaint.dart';
import 'package:pinkey/view/manager/widgets/button_app.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

class ComplaintViewBody extends StatelessWidget {
  final ReportProvider reportProvider;
  ComplaintViewBody({required this.reportProvider});
final complaintController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppStringsManager.complaint_details),
            const SizedBox(height: AppSize.s20,),
            TextFormField(
              controller: complaintController,
              decoration: InputDecoration(
                hintText: AppStringsManager.please_enter_complaint_details,
                hintStyle: getRegularStyle(
                  color: ColorManager.lightGray,
                  fontSize: 10.sp,
                ),

              ),validator: (val){
              if(val!.trim().isEmpty)
                return AppStringsManager.filed_Required;
              return null;
            },
              maxLines: 9,
              minLines: 8,
            ),
            const Spacer(),
            ButtonApp(text: AppStringsManager.send_complaint_al, onPressed: () async {
            if(formKey.currentState!.validate()){
              Const.LOADIG(context);
              final result=await reportProvider.addReport(context, details: complaintController.text);
              Get.back();
              if(result['status'])
                 Get.back();
            }

             // Get.to(()=>AllComplaint());
            })

          ],
        ),
      ),
    );
  }
}
