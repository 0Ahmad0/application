import 'package:flutter/material.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';
import '../../model/models.dart';
import '../resourse/assets_manager.dart';
import '../resourse/style_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrainerDetailsView extends StatefulWidget {
  final Trainer trainer;

  const TrainerDetailsView({super.key, required this.trainer});

  @override
  State<TrainerDetailsView> createState() => _TrainerDetailsViewState();
}

class _TrainerDetailsViewState extends State<TrainerDetailsView> {
  bool showDetails = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.trainer.name),
            leading: const BackButton(
              color: ColorManager.black,
            ),
          ),
          body: NestedScrollView(
            scrollDirection: Axis.vertical,
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [
              SliverToBoxAdapter( //headerSilverBuilder only accepts slivers
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                            color: ColorManager.lightGray,
                            shape: BoxShape.circle),
                        child: ClipOval(
                          child: Image.asset(
                            widget.trainer.image,
                            width: 28.w,
                            height: 28.w,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        widget.trainer.name,
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: 14.sp),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        widget.trainer.type_of_work_permit,
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: 10.sp),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: ColorManager.lightGray
                                  .withOpacity(.15),
                              child: SvgPicture.asset(
                                  AssetsManager.border_heartIMG),
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s16,
                          ),
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: ColorManager.lightGray
                                  .withOpacity(.15),
                              child: SvgPicture.asset(
                                  AssetsManager.trainer_locationIMG),
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s16,
                          ),
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: ColorManager.lightGray
                                  .withOpacity(.15),
                              child: SvgPicture.asset(
                                  AssetsManager.triner_emailIMG),
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s16,
                          ),
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: ColorManager.lightGray
                                  .withOpacity(.15),
                              child: SvgPicture.asset(
                                  AssetsManager.trainer_phoneIMG),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Divider(
                        color: ColorManager.lightGray,
                        thickness: .8,
                      ),
                      Text('عن ${widget.trainer.name}'),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد'
                              'تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل'
                              'هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد'
                              'الحروف التى يولدها التطبيق شاهدي المزيد'),
                      Divider(
                        color: ColorManager.lightGray,
                        thickness: .8,
                      ),
                    ],
                  ),
                ),
              ),

            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsManager.trainer_courseIMG),
                            const SizedBox(width: AppSize.s4,),
                            Text(AppStringsManager.trainer_courses,
                              style: getRegularStyle(
                                  color: ColorManager.black
                              ),),

                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsManager.trainer_reviewsIMG),
                            const SizedBox(width: AppSize.s4,),
                            Text(AppStringsManager.trainer_review,
                              style: getRegularStyle(
                                  color: ColorManager.black
                              ),),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppPadding.p8),
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
                                      SvgPicture.asset(
                                          AssetsManager.trainer_course_nameIMG),
                                      const SizedBox(width: AppSize.s4,),
                                      const Text(
                                          AppStringsManager
                                              .trainer_courses_name),
                                      const SizedBox(width: AppSize.s4,),
                                      Text(
                                        '(للمبتدئين)', style: getRegularStyle(
                                          color: ColorManager.lightGray
                                      ),),
                                    ],
                                  ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                    right: AppPadding.p30
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                          'هذه المكان مخصص لوضع عنوان مناسب للدورة المقدمة'),
                                      const SizedBox(height: AppSize.s10,),
                                      TextButton(
                                        onPressed: (){
                                          showDetails = !showDetails;
                                          setState((){});
                                        },
                                        child: Text(
                                          AppStringsManager.show_trainer_course_details,
                                          style: getRegularStyle(
                                              color: ColorManager.primaryColor,
                                              fontSize: 10.sp
                                          ),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: showDetails,
                                child: Row(
                                  children: [Row(
                                    children: [
                                      Text('سيارتي 900 ر.س',style:
                                      getRegularStyle(
                                          color: ColorManager.black,
                                          fontSize: 8.sp
                                      ),),
                                      Icon(Icons.monetization_on)
                                    ],
                                  ),
                                  ],
                                ),
                              )


                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
