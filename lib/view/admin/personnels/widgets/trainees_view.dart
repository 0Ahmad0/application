import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../controller/provider/account_provider.dart';
import '../../../../controller/provider/chat_provider.dart';
import '../../../../model/models.dart';
import '../../../../model/utils/const.dart';
import '../../../../model/utils/consts_manager.dart';
import '../../../app/picture/cach_picture_widget.dart';
import '../../../chat/widgets/chat_room.dart';
import '../../../manager/widgets/button_app.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
import '../../../resourse/values_manager.dart';

class TraineesView extends StatefulWidget {
  TraineesView({Key? key}) : super(key: key);

  @override
  State<TraineesView> createState() => _TraineesViewState();
}

class _TraineesViewState extends State<TraineesView> {
  final searchController = TextEditingController();
  var getAccountUser;
  late AccountProvider accountProvider;
  getAccountUserFun()  {
    getAccountUser = FirebaseFirestore.instance.collection(AppConstants.collectionUser)
        .snapshots();
    return getAccountUser;
  }
  @override
  void initState() {
    getAccountUserFun();
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
            stream: getAccountUser,
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
                  accountProvider.users.users.clear();
                  if(snapshot.data!.docs!.length>0){
                    accountProvider.users=Users.fromJson(snapshot.data!.docs!);
                    accountProvider.users.users=accountProvider.searchUsersByName(searchController.text, accountProvider.users.users);
                  }

                  return ListBody(
                    children: [
                      for (int i = 0; i < accountProvider.users.users.length; i++) BuildPersonalTraineeItem(
                        index: i,
                        user: accountProvider.users.users[i],
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

class BuildPersonalTraineeItem extends StatelessWidget {
  const BuildPersonalTraineeItem({Key? key, required this.index, required this.user}) : super(key: key);
  final int index;
  final User user;
  @override
  Widget build(BuildContext context) {
    AccountProvider accountProvider = Provider.of<AccountProvider>(context);
    ChatProvider chatProvider=Provider.of<ChatProvider>(context);
    ProfileProvider profileProvider=Provider.of<ProfileProvider>(context);
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
                Text(
                    user.name
                //    'لمى يوسف '
                ),
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
              Visibility(
                visible: !user.band,
                child: Expanded(
                  flex: 4,
                  child: ButtonApp(
                      color: ColorManager.thirdlyColor,
                      height: AppSize.s40,
                      fontSize: 10.sp,
                      text: AppStringsManager.send_message,
                      onPressed: () async {
                        chatProvider.chat.listIdUser=[profileProvider.user.id,user.id];
                        Const.LOADIG(context);
                        await  chatProvider.fetchChatByListIdUser(listIdUser: chatProvider.chat.listIdUser);
                        Get.back();
                        Get.to(()=>ChatRoom(recId:user.id,),transition: Transition.downToUp);
                      }),
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
      ),
    );
  }
}
