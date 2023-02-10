import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinkey/controller/date_trainer_controller.dart';
import 'package:pinkey/controller/provider/date_trainer_provider.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:pinkey/model/models.dart';
import 'package:provider/provider.dart';
import '../../../../model/utils/const.dart';
import '../../../../model/utils/consts_manager.dart';
import '../../add_new_course/add_new_course_view.dart';
import '/view/chat/widgets/chat_room.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../manager/widgets/container_icons.dart';
import '../../../resourse/assets_manager.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/string_manager.dart';
import '../../../resourse/style_manager.dart';

class TrainerAppointmentsViewBody extends StatefulWidget {
  const TrainerAppointmentsViewBody({Key? key}) : super(key: key);

  @override
  State<TrainerAppointmentsViewBody> createState() => _TrainerAppointmentsViewBodyState();
}

class _TrainerAppointmentsViewBodyState extends State<TrainerAppointmentsViewBody> {
  var getDateTrainer;
  late ProfileProvider profileProvider;
  late DateTrainerController dateTrainerController;
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    getDateTrainerFun();
    super.initState();
  }

  getDateTrainerFun() async {
    getDateTrainer = FirebaseFirestore.instance
        .collection(AppConstants.collectionDateTrainer)
        .where('idTrainer',isEqualTo: profileProvider.user.id)
        .snapshots();

    return getDateTrainer;
  }
  @override
  Widget build(BuildContext context) {
    dateTrainerController= DateTrainerController(context: context);
    return StreamBuilder<QuerySnapshot>(
      //prints the messages to the screen0
        stream: getDateTrainer,
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

               dateTrainerController.dateTrainerProvider.dateTrainers=DateTrainers.fromJson(snapshot.data!.docs);

              }else{
                dateTrainerController.dateTrainerProvider.dateTrainers.listDateTrainer.clear();
              }

              return buildDateTrainer();
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
  buildDateTrainer(){
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
        Text(
          AppStringsManager.my_schedule,
          style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        for (int i = 0; i < 3; i++)
          buildCoursesDetails(date: DateTime.now())
      ],
    );
  }
  Widget buildCoursesDetails({required DateTime date}) {
    return Container(
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
                SvgPicture.asset(AssetsManager.appointmentsIMG,color: ColorManager.secondaryColor,),
                const SizedBox(
                  width: AppSize.s4,
                ),
                const Text(AppStringsManager.date),

              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(right: AppPadding.p30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text('${DateFormat.yMd().format(date)}',style: getRegularStyle(
                    color: ColorManager.secondaryColor,
                    fontSize: 10.sp
                  ),),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildContainerDetailsTrainer(
                  text:
                  '${AppStringsManager.day} : ${DateFormat('','ar').add_EEEE().format(DateTime.now())}',
                  icon: SvgPicture.asset(
                    AssetsManager.date_in_dayIMG,
                    color: ColorManager.secondaryColor,
                    width: 16.sp,
                    height: 16.sp,
                  )),
              buildContainerDetailsTrainer(
                  text:
                      '${DateFormat().add_Hm().format(DateTime.now()) + ' - ' + DateFormat().add_Hm().format(DateTime.now())}',
                  icon: Icon(
                    Icons.access_time_filled,
                    size: 16.sp,
                    color: ColorManager.secondaryColor,
                  )),
              InkWell(
                onTap: (){
                  Get.to(()=>AddNewCourseView(),transition: Transition.rightToLeftWithFade);

                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(AppPadding.p8),
                  width: 20.w,
                  decoration: BoxDecoration(
                      color: ColorManager.thirdlyColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(20.sp)
                  ),
                  child: Text(AppStringsManager.edit,style: getRegularStyle(
                      color: ColorManager.thirdlyColor,
                      fontSize: 12.sp
                  ),),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
