import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../controller/provider/account_provider.dart';
import '../../../../model/models.dart';
import '../../../../model/utils/const.dart';
import '../../../../model/utils/consts_manager.dart';
import '../../../app/picture/cach_picture_widget.dart';
import '../../../manager/widgets/button_app.dart';
import '../../../manager/widgets/container_icons.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
import '../../../triner_details/trainer_details_view.dart';

class AdminRequestViewBody extends StatefulWidget {
  const AdminRequestViewBody({Key? key, required this.accountProvider}) : super(key: key);
  final  AccountProvider accountProvider;
  @override
  State<AdminRequestViewBody> createState() => _AdminRequestViewBodyState();
}

class _AdminRequestViewBodyState extends State<AdminRequestViewBody> {

  var getAccount;


  getAccountFun()  {
    getAccount = FirebaseFirestore.instance.collection(AppConstants.collectionTrainer)
        .where('active',isEqualTo: false)
    .snapshots();
        //.orderBy('dateTime').snapshots();
    //widget.accountProvider.fetchTrainerRequestsStream(context);
    return getAccount;
  }
  @override
  void initState() {
    getAccountFun();
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
            AppStringsManager.requests,
            style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                //prints the messages to the screen0
                  stream: getAccount,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return
                        Const.SHOWLOADINGINDECATOR();

                    }
                    else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        Const.SHOWLOADINGINDECATOR();
                        widget.accountProvider.trainerRequests.users.clear();
                        if(snapshot.data!.docs!.length>0){
                          widget.accountProvider.trainerRequests=Users.fromJson(snapshot.data!.docs!);
                        }

                        return ListView.builder(
                          itemCount: widget.accountProvider.trainerRequests.users.length,
                          itemBuilder: (_, index) => BuildAdminRequestItem(index: index),
                        );
                        /// }));
                      } else {
                        return const Text('Empty data');
                      }
                    }
                    else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  }))
        ],
      ),
    );
  }
}

class BuildAdminRequestItem extends StatelessWidget {
  final int index;

   BuildAdminRequestItem({super.key, required this.index});
  late  AccountProvider accountProvider;
  @override
  Widget build(BuildContext context) {
    accountProvider=Provider.of<AccountProvider>(context);
    return Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.sp),
          border: Border.all(color: ColorManager.borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  color: ColorManager.borderColor,
                  child: CacheNetworkImage(
                    photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                    '${accountProvider.trainerRequests.users[index].photoUrl}',
                    width: 40.w,
                    height: 40.w,
                    boxFit: BoxFit.fill,
                    waitWidget:  Image.asset(
                      AssetsManager.trainerIMG,
                    ),
                    errorWidget:  Image.asset(
                        AssetsManager.trainerIMG
                      //'assets/images/profile.png',
                    ),
                  )),
            ),
            const SizedBox(
              width: AppSize.s10,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                          accountProvider.trainerRequests.users[index].name
                        // 'عبير عبد الغني'
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: AppPadding.p14),
                        child: Text(
                          'رخصة عمل حر',
                          style: getRegularStyle(
                              color: ColorManager.black, fontSize: 10.sp),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AssetsManager.locationIMG),
                        const SizedBox(width: AppSize.s4,),
                        Flexible(
                            child: Text(
                              '${accountProvider.trainerRequests.users[index].trainerInfo?.city}, ${accountProvider.trainerRequests.users[index].trainerInfo?.neighborhood}',
                          //'جدة, حي نظار, شارع النور',
                          style: getRegularStyle(
                            color: ColorManager.lightGray,
                            fontSize: 10.sp
                          ),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonApp(
                            color: ColorManager.thirdlyColor,
                            height: AppSize.s40,
                            fontSize: 10.sp,
                            text: AppStringsManager.acception_trainer,
                            onPressed: () async {
                              await accountProvider.activeAccount(context, user: accountProvider.trainerRequests.users[index]);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: AppSize.s4,
                        ),
                        Expanded(
                          child: ButtonApp(
                            borderColor: ColorManager.thirdlyColor,
                            color: ColorManager.white,
                            textColor: ColorManager.thirdlyColor,
                            fontSize: 10.sp,
                            height: AppSize.s40,
                            text: AppStringsManager.trainer_details,
                            onPressed: () {
                              Get.to(()=> TrainerDetailsView(
                                trainer: accountProvider.trainerRequests.users[index],
                              ));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}
