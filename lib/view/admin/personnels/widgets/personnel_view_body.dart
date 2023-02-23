import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pinkey/view/admin/personnels/widgets/trainees_view.dart';
import 'package:pinkey/view/admin/personnels/widgets/trainers_view.dart';

import '../../../../controller/provider/account_provider.dart';
import '../../../../model/utils/consts_manager.dart';
import '../../../resourse/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../../controller/provider/report_provider.dart';
import '../../../../model/utils/const.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';

class PersonnelViewBody extends StatefulWidget {
  const PersonnelViewBody({Key? key,required this.accountProvider}) : super(key: key);
  final  AccountProvider accountProvider;
  @override
  State<PersonnelViewBody> createState() => _PersonnelViewBodyState();
}

class _PersonnelViewBodyState extends State<PersonnelViewBody> {


  late PageController _pageController;
  int _selectedIndex = 0;
  List<String> complaintType = [
    AppStringsManager.trainers,
    AppStringsManager.trainees,
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
            AppStringsManager.personals,
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
          Expanded(child:
              buildPageView(context)
          ),
        ],
      ),
    );
  }
  buildPageView(BuildContext context){
    return PageView(
      controller: _pageController,
      onPageChanged: (index){
        _selectedIndex = index;
        setState(() {

        });

      },
      children: [
        // widget.reportProvider.listNewReport.length>0?
        TrainersView(),
        TraineesView(),
        //     :SvgPicture.asset(
        //   AssetsManager.emptyIMG,
        //   width: 100,
        //   height: 100,
        // ),
        // widget.reportProvider.listoldReport.length>0?
        //     :SvgPicture.asset(
        //   AssetsManager.emptyIMG,
        //   width: 100,
        //   height: 100,
        // ),
      ],
    );
  }

}
