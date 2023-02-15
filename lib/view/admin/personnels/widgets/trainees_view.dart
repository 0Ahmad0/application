import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../app/picture/cach_picture_widget.dart';
import '../../../manager/widgets/button_app.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
import '../../../resourse/values_manager.dart';

class TraineesView extends StatelessWidget {
  TraineesView({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            AppStringsManager.all_trainer,
            style: getRegularStyle(color: Colors.black, fontSize: 14.sp),
          ),
        ),
        TextFormField(
          controller: searchController,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: SvgPicture.asset(AssetsManager.search_iconIMG),
              ),
              hintText: AppStringsManager.search_trainer,
              hintStyle: getRegularStyle(
                color: ColorManager.hintColor,
                fontSize: 12.sp,
              )),
          onChanged: (val) {
            // homeProvider.notifyListeners();
          },
        ),
        SizedBox(
          height: 10.sp,
        ),
        for (int i = 0; i < 5; i++) BuildPersonalTraineeItem()
      ],
    );
  }
}

class BuildPersonalTraineeItem extends StatelessWidget {
  const BuildPersonalTraineeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      decoration: BoxDecoration(
          color: ColorManager.white,
          border: Border.all(color: ColorManager.borderColor),
          borderRadius: BorderRadius.circular(6.sp)),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(AssetsManager.profileIMG),
            title: const Text(AppStringsManager.trainee_name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppSize.s10,
                ),
                Text('لمى يوسف '),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero
                  ),
                    onPressed: () {},
                    child: Text(
                      AppStringsManager.show_trainee_details,
                      style: getRegularStyle(
                        color: ColorManager.primaryColor,
                        fontSize: 10.sp
                      ),
                    ))
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: ButtonApp(
                    color: ColorManager.thirdlyColor,
                    height: AppSize.s40,
                    fontSize: 10.sp,
                    text: AppStringsManager.send_message,
                    onPressed: () {}),
              ),
              const SizedBox(
                width: AppSize.s4,
              ),
              Expanded(
                flex: 4,
                child: ButtonApp(

                    color: ColorManager.white,
                    borderColor: ColorManager.thirdlyColor,
                    textColor: ColorManager.thirdlyColor,
                    height: AppSize.s40,
                    fontSize: 12.sp,
                    text: AppStringsManager.band_account,
                    onPressed: () {}),
              ),

              /// favorite button
              /* const SizedBox(width: AppSize.s4,),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            widget.trainer.isFav =!widget.trainer.isFav;
                            print(widget.trainer.isFav);
                            setState(() {

                            });
                          },
                          child: Container(
                            height: AppSize.s40,
                            width: AppSize.s40,
                            padding: const EdgeInsets.all(AppPadding.p4),
                            decoration: BoxDecoration(
                              color: ColorManager.thirdlyColor.withOpacity(.3),
                              borderRadius: BorderRadius.circular(6.sp)
                            ),
                            child: SvgPicture.asset(
                              widget.trainer.isFav
                                  ? AssetsManager.fill_heartIMG
                                  :AssetsManager.border_heartIMG,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      )*/
            ],
          )

        ],
      ),
    );
  }
}
