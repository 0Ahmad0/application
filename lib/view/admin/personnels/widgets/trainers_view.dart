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
class TrainersView extends StatelessWidget {
 TrainersView({Key? key}) : super(key: key);
final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            AppStringsManager.all_trainee,
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
              hintText: AppStringsManager.search_trainee,
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
        for (int i = 0; i < 5; i++) BuildPersonalTrainerItem()
      ],
    );
  }
}

class BuildPersonalTrainerItem extends StatelessWidget {
  const BuildPersonalTrainerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      decoration: BoxDecoration(
          color: ColorManager.white,
          border: Border.all(color: ColorManager.borderColor),
          borderRadius: BorderRadius.circular(6.sp)),
      child: Row(
        children: [
          Expanded(
              child: CacheNetworkImage(
                photoUrl:
                "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                // '${trainer.photoUrl}',
                width: 40.w,
                height: 40.w,
                boxFit: BoxFit.fill,
                waitWidget: Image.asset(AssetsManager.trainerIMG),
                errorWidget: Image.asset(AssetsManager.trainerIMG
                  //'assets/images/profile.png',
                ),
              )
            // Image.asset(widget.trainer.image,width: 100.sp,height: 100.sp,)
          ),
          SizedBox(
            width: 10.sp,
          ),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'عبير عبد الغني',
                    style: getRegularStyle(color: ColorManager.black),
                  ),
                  const SizedBox(
                    height: AppSize.s6,
                  ),
                  Text(
                    'رخصة عمل حر',
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: 10.sp),
                  ),
                  const SizedBox(
                    height: AppSize.s6,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManager.locationIMG),
                      Text(
                        'asdasdasd',
                        // '${widget.trainer.trainerInfo!.city} - ${widget.trainer.trainerInfo!.neighborhood}',
                        style: getRegularStyle(
                            color: ColorManager.lightGray, fontSize: 10.sp),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s20,
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
              )),
        ],
      ),
    );
  }
}
