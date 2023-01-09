import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/view/complaint/widgets/all_complaint.dart';
import 'package:pinkey/view/manager/widgets/button_app.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

class ComplaintViewBody extends StatelessWidget {
final complaintController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
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
            ),
            maxLines: 9,
            minLines: 8,
          ),
          const Spacer(),
          ButtonApp(text: AppStringsManager.send_complaint_al, onPressed: (){
            Get.to(()=>AllComplaint());
          })

        ],
      ),
    );
  }
}
