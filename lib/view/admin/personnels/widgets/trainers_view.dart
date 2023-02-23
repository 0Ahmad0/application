import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinkey/controller/provider/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/models.dart';
import '../../../../model/utils/const.dart';
import '../../../../model/utils/consts_manager.dart';
import '../../../app/picture/cach_picture_widget.dart';
import '../../../manager/widgets/button_app.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
import '../../../resourse/values_manager.dart';
class TrainersView extends StatefulWidget {
 TrainersView({Key? key}) : super(key: key);

  @override
  State<TrainersView> createState() => _TrainersViewState();
}

class _TrainersViewState extends State<TrainersView> {
final searchController = TextEditingController();

var getAccountTrainer;
late AccountProvider accountProvider;
getAccountTrainerFun()  {
  getAccountTrainer = FirebaseFirestore.instance.collection(AppConstants.collectionTrainer)
      .where('active',isEqualTo: true)
      .snapshots();
  return getAccountTrainer;
}
@override
void initState() {
  getAccountTrainerFun();
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    accountProvider= Provider.of<AccountProvider>(context);
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
            setState(() {
            });
            // homeProvider.notifyListeners();
          },
        ),
        SizedBox(
          height: 10.sp,
        ),
        StreamBuilder<QuerySnapshot>(
          //prints the messages to the screen0
            stream: getAccountTrainer,
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
                  accountProvider.trainers.users.clear();
                  if(snapshot.data!.docs!.length>0){
                   accountProvider.trainers=Users.fromJson(snapshot.data!.docs!);
                   accountProvider.trainers.users=accountProvider.searchUsersByName(searchController.text, accountProvider.trainers.users);

                  }

                  return ListBody(
                    children: [
                      for (int i = 0; i < accountProvider.trainers.users.length; i++) BuildPersonalTrainerItem(
                        index: i,
                        user: accountProvider.trainers.users[i],
                      )
                    ],
                  );
                  /// }));
                } else {
                  return const Text('Empty data');
                }
              }
              else {
                return Text('State: ${snapshot.connectionState}');
              }
            })
      ],
    );
  }
}

class BuildPersonalTrainerItem extends StatelessWidget {
  const BuildPersonalTrainerItem({Key? key,required this.user,required this.index}) : super(key: key);
  final int index;
  final User user;
  @override
  Widget build(BuildContext context) {
    AccountProvider accountProvider = Provider.of<AccountProvider>(context);
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
                user.photoUrl,
                //"https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
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
                    user.name,
                    //'عبير عبد الغني',
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
                        '${user.trainerInfo?.city}, ${user.trainerInfo?.neighborhood}',

                        //'asdasdasd',
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
                      Visibility(
                        visible: !user.band,
                        child: Expanded(
                          flex: 4,
                          child: ButtonApp(
                              color: ColorManager.thirdlyColor,
                              height: AppSize.s40,
                              fontSize: 10.sp,
                              text: AppStringsManager.send_message,
                              onPressed: () {}),
                        ),
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
                            text: !user.band?AppStringsManager.band_account:AppStringsManager.active_account,
                            onPressed: () async {
                              await accountProvider.updateBandAccount(context,user: user);
                            }),
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
