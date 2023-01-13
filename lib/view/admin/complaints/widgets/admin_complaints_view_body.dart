import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
import 'new_complaint.dart';
import 'old_complaint.dart';

class AdminComplaintsViewBody extends StatefulWidget {
  const AdminComplaintsViewBody({Key? key}) : super(key: key);

  @override
  State<AdminComplaintsViewBody> createState() => _AdminComplaintsViewBodyState();
}

class _AdminComplaintsViewBodyState extends State<AdminComplaintsViewBody> {
  late PageController _pageController;
  int _selectedIndex = 0;
  List<String> complaintType = [
    AppStringsManager.new_complaint,
    AppStringsManager.old_complaint,
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStringsManager.complaint,
            style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
          ),
          const SizedBox(height: AppSize.s10,),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppPadding.p6),
            decoration: BoxDecoration(
                color: ColorManager.borderColor,
                borderRadius: BorderRadius.circular(50.sp)),
            child: Row(
              children: [
                for (int i = 0; i < complaintType.length; i++)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectedIndex = i ;
                        _pageController.animateToPage(_selectedIndex,
                            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

                        setState(() {
                        });
                      },
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        height: AppSize.s50,
                        duration: const Duration(milliseconds: 500),
                        padding: const EdgeInsets.all(AppPadding.p10),
                        decoration: BoxDecoration(
                          color: _selectedIndex == i
                              ? ColorManager.thirdlyColor
                              : ColorManager.borderColor,
                          borderRadius: BorderRadius.circular(50.sp),
                        ),
                        child: Text(complaintType[i],style: getRegularStyle(
                            color: _selectedIndex == i
                                ? ColorManager.white
                                : ColorManager.lightGray,
                            fontSize: 10.sp
                        ),),
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Expanded(child: PageView(
            controller: _pageController,
            onPageChanged: (index){
              _selectedIndex = index;
              setState(() {

              });

            },
            children: [
              NewComplaint(),
              OldComplaint(),
            ],
          )),
        ],
      ),
    );
  }
}
