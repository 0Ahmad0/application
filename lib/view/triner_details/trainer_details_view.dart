import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/widgets/container_icons.dart';
import '/view/book_course/book_course_view.dart';
import '/view/manager/app_launcher.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/string_manager.dart';
import '/view/resourse/values_manager.dart';
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

class _TrainerDetailsViewState extends State<TrainerDetailsView>
    with SingleTickerProviderStateMixin {
  bool showDetails = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

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
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                //headerSilverBuilder only accepts slivers
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
                              backgroundColor:
                                  ColorManager.lightGray.withOpacity(.15),
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
                              backgroundColor:
                                  ColorManager.lightGray.withOpacity(.15),
                              child: SvgPicture.asset(
                                  AssetsManager.trainer_locationIMG),
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s16,
                          ),
                          InkWell(
                            onTap: () async {
                              await  AppLauncher.launchEmail(
                                  email: 'ah74129@gmail.com');
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  ColorManager.lightGray.withOpacity(.15),
                              child: SvgPicture.asset(
                                  AssetsManager.triner_emailIMG),
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s16,
                          ),
                          InkWell(
                            onTap: () async {
                              await AppLauncher.launchPhone(
                                  phoneNumber: '0954872922');
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  ColorManager.lightGray.withOpacity(.15),
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
                    controller: _tabController,
                    onTap: (index) {
                      _tabController.index = index;
                      setState(() {});
                    },
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetsManager.trainer_courseIMG,
                              color: _tabController.index == 0
                                  ? ColorManager.secondaryColor
                                  : ColorManager.lightGray,
                            ),
                            const SizedBox(
                              width: AppSize.s4,
                            ),
                            Text(
                              AppStringsManager.trainer_courses + " " + "(8)",
                              style: getRegularStyle(
                                  color: _tabController.index == 0
                                      ? ColorManager.black
                                      : ColorManager.lightGray),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetsManager.trainer_reviewsIMG,
                              color: _tabController.index == 1
                                  ? ColorManager.secondaryColor
                                  : ColorManager.lightGray,
                            ),
                            const SizedBox(
                              width: AppSize.s4,
                            ),
                            Text(
                              AppStringsManager.trainer_review + " " + "(30)",
                              style: getRegularStyle(
                                  color: _tabController.index == 1
                                      ? ColorManager.black
                                      : ColorManager.lightGray),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        ///Courses
                        ListView.builder(
                          itemCount: 10,
                          itemBuilder: (_, index) {
                            return buildTrainerCourseItem();
                          },
                        ),

                        ///Reviews
                        ListView.separated(
                            itemBuilder: (_, index) {
                              return buildContainerReviews();
                            },
                            separatorBuilder: (_, __) {
                              return Divider(
                                thickness: .8,
                                color: ColorManager.lightGray,
                              );
                            },
                            itemCount: 5)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Column buildContainerReviews() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            alignment: Alignment.center,
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
                color: ColorManager.lightGray.withOpacity(.3),
                shape: BoxShape.circle,
                border: Border.all(color: ColorManager.lightGray)),
            child: ClipOval(
              child: Image.asset(
                widget.trainer.image,
                width: 12.w,
                height: 12.w,
              ),
            ),
          ),
          title: Text(
            widget.trainer.name,
          ),
          subtitle: Row(
            children: [
              SvgPicture.asset(AssetsManager.starIMG),
              Text('4.9'),
            ],
          ),
        ),
        Text(
          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة'
          'لقد تم توليد هذا النص من مولد النص العربى',
          style:
              getRegularStyle(color: ColorManager.lightGray, fontSize: 12.sp),
        )
      ],
    );
  }

  Container buildTrainerCourseItem() {
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
                SvgPicture.asset(AssetsManager.trainer_course_nameIMG),
                const SizedBox(
                  width: AppSize.s4,
                ),
                const Text(AppStringsManager.trainer_courses_name),
                const SizedBox(
                  width: AppSize.s4,
                ),
                Text(
                  '(للمبتدئين)',
                  style: getRegularStyle(color: ColorManager.lightGray),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(right: AppPadding.p30),
              child: Column(
                children: [
                  const SizedBox(height: AppSize.s10,),
                  const Text('هذه المكان مخصص لوضع عنوان مناسب للدورة المقدمة',),
                  Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero
                        ),
                        onPressed: () {
                          showDetails = !showDetails;
                          setState(() {});
                        },
                        child: Text(
                          AppStringsManager.show_trainer_course_details,
                          style: getRegularStyle(
                              color: ColorManager.primaryColor, fontSize: 10.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: showDetails,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildContainerDetailsTrainer(
                    text: 'سيارتي 900 ر.س',
                    icon: Icon(
                      Icons.monetization_on,
                      size: 16.sp,
                      color: ColorManager.secondaryColor,
                    )),
                buildContainerDetailsTrainer(
                    text: 'المتدربة 800 ر.س',
                    icon: Icon(
                      Icons.monetization_on,
                      size: 16.sp,
                      color: ColorManager.secondaryColor,
                    )),
                buildContainerDetailsTrainer(
                    text: '4 أيام',
                    icon: SvgPicture.asset(
                      AssetsManager.appointmentsIMG,
                      color: ColorManager.secondaryColor,
                      width: 16.sp,
                      height: 16.sp,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          ButtonApp(
              radius: AppSize.s100,
              height: AppSize.s50,
              text: AppStringsManager.course_booking,
              onPressed: () {
                Get.to(() => const BookCourseView());
              })
        ],
      ),
    );
  }

}