import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../controller/provider/account_provider.dart';
import '../../../../model/models.dart';
import '../../../../model/utils/const.dart';
import '../../../manager/widgets/button_app.dart';
import '../../../manager/widgets/container_icons.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';
import '../../../resourse/values_manager.dart';

class NewRequestPage extends StatefulWidget {
  @override
  State<NewRequestPage> createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  List<Trainer> _trainerList = [
    Trainer(image: 'assets/images/1.png',
        name: 'نور محمد الخالدي',
        type_of_work_permit: 'رخصة عمل حر',
        location: 'جدة, حي نظار, شارع النور',
        rate: 4.9,
        isFav: true
    ),
    Trainer(image: 'assets/images/2.png',
        name: 'نور محمد الخالدي',
        type_of_work_permit: 'رخصة عمل حر',
        location: 'جدة, حي نظار, شارع النور',
        rate: 4.9,
        isFav: false
    ),
    Trainer(image: 'assets/images/3.png',
        name: 'نور رحمة',
        type_of_work_permit: 'رخصة عمل حر',
        location: 'السعودية, الدار البيضاء, حي الرادرات',
        rate: 4.9,
        isFav: false
    ),
  ];
  late  AccountProvider accountProvider;
  var getAccount;


  getAccountFun() async {
    getAccount = accountProvider.fetchTrainerRequestsStream(context);
    return getAccount;
  }
  @override
  void initState() {
    getAccountFun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
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
              if(snapshot.data!.docs!.length>0){
                accountProvider.trainerRequests=Users.fromJson(snapshot.data!.docs!);
              }

              return ListView(
                children: [
                  for(int i = 0 ; i <accountProvider.trainerRequests.users.length;i++ )
                    BuildNewRequestItem(trainer: accountProvider.trainerRequests.users[i],)
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
        });
  }
}

class BuildNewRequestItem extends StatefulWidget {
  final User trainer;

  const BuildNewRequestItem({super.key, required this.trainer});

  @override
  State<BuildNewRequestItem> createState() => _BuildNewRequestItemState();
}

class _BuildNewRequestItemState extends State<BuildNewRequestItem> {
  bool showDetails = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(AppPadding.p8),
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.sp),
            border: Border.all(color: ColorManager.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    SvgPicture.asset(AssetsManager.profileIMG),
                    const SizedBox(
                      width: AppSize.s4,
                    ),
                    const Text(AppStringsManager.student_name),

                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSize.s4,),
                       Text(widget.trainer.name,style: getRegularStyle(
                         color: ColorManager.secondaryColor,
                         fontSize: 10.sp
                       ),),
                      const SizedBox(height: AppSize.s10,),
                      InkWell(
                        onTap: (){
                          showDetails = !showDetails;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Text(
                              showDetails
                                  ?AppStringsManager.show_details_custom_course
                                  :AppStringsManager.show_details_custom_course,
                              style: getRegularStyle(
                                  color: ColorManager.primaryColor, fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s4,),
              Visibility(
                visible: showDetails,
                child: Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p30),
                  child: Text(':تهدف الدورة الي\n'
                      'إعطاء الطلبات فكرة عامة عن القيادة *\n'
                      'تعليم الطالبات أسماء المتحكمات *\n'
                      'كيفية تشغيل وإيقاف السيارة *',style: getRegularStyle(
                      color: ColorManager.secondaryColor,
                      fontSize: 10.sp
                  ),),
                ),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildContainerDetailsTrainer(
                      text: '${DateFormat.yMd().format(DateTime.now())}',
                      icon: SvgPicture.asset(
                        AssetsManager.appointmentsIMG,
                        color: ColorManager.secondaryColor,
                        width: 16.sp,
                        height: 16.sp,
                      )),
                  buildContainerDetailsTrainer(
                      text:
                      '${DateFormat().add_Hm().format(DateTime.now()) + ' - ' + DateFormat().add_Hm().format(DateTime.now())}',
                      icon: Icon(
                        Icons.access_time_filled_rounded,
                        size: 16.sp,
                        color: ColorManager.secondaryColor,
                      )),


                  buildContainerDetailsTrainer(
                      text: '800 ر.س',
                      icon: Icon(
                        Icons.monetization_on,
                        size: 16.sp,
                        color: ColorManager.secondaryColor,
                      )),
                ],
              ),
const SizedBox(height: AppSize.s10,),
              Row(
                children: [
                  Expanded(
                    child: ButtonApp(
                      radius: 100.sp,
                      height: AppSize.s50,
                      fontSize: 10.sp,
                      text: AppStringsManager.acception_request,
                      onPressed: () {
                      },
                    ),
                  ),
                  const SizedBox(width: AppSize.s10,),
                  Expanded(
                    child: ButtonApp(
                      borderColor: ColorManager.primaryColor,
                      color: ColorManager.white,
                      textColor: ColorManager.primaryColor,
                      radius: 100.sp,
                      fontSize: 10.sp,
                      height: AppSize.s50,
                      text: AppStringsManager.rejection_request,
                      onPressed: () {},
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
        Positioned(
            left: 20.sp,
            top: 25.sp,
            child: Row(
              children: [
                SvgPicture.asset(AssetsManager.locationIMG),
                Text('الزهراء - حي الراشد',style: getRegularStyle(
                    color: ColorManager.secondaryColor,
                    fontSize: 8.sp
                ),),
              ],
            )
        ),
      ],
    );
  }

}
