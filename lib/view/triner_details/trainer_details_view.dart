import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/picture/cach_picture_widget.dart';
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
  final User trainer;

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
                          child:
                          CacheNetworkImage(
                            photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                            '${widget.trainer.photoUrl}',
                            width: 28.w,
                            height: 28.w,
                           // boxFit: BoxFit.fill,
                            waitWidget:  Image.asset(
                              AssetsManager.trainerIMG,
                            ),
                            errorWidget:  Image.asset(
                              AssetsManager.trainerIMG,
                            ),
                          )
                          // Image.asset(
                          //   widget.trainer.image,
                          //   width: 28.w,
                          //   height: 28.w,
                          // ),
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
                        '${widget.trainer.trainerInfo?.typeOfWork}',
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
                         /*
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
                         */
                          InkWell(
                            ///TODO Locatiom
                            ///widget.trainer.latitude widget.trainer.longitude
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
                                  email: widget.trainer.email//'mawadah2000@outlook.com'
                              );
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
                                  phoneNumber: widget.trainer.phoneNumber//'+966544854535'
                              );
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
                      const Divider(
                        color: ColorManager.lightGray,
                        thickness: .8,
                      ),
                      Row(
                        children: [
                          Text('عن ${widget.trainer.name}'),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                    Row(
                      children: [
                        Expanded(child:   Text(
                    '${widget.trainer.description}',),),
                            // 'حاصله على رخصة عمل حر'
                            //     'خبره في التدريب على قيادة السيارات'
                            //     'دربت اكثر من 50 متدربة'
                            //     'اقدم شروحات نموذجيه لقيادة امنه واحترافيه '),),
                        Expanded(child: SizedBox())
                      ],
                    ),
                      const Divider(
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
                              AppStringsManager.trainer_courses + " " + "(3)",
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
                              AppStringsManager.trainer_review + " " + "(2)",
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
                          itemCount: 3,
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
                            itemCount: 2)
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
              child:
              CacheNetworkImage(
                photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
               'd',// '${widget.trainer.photoUrl}',
                width: 12.w,
                height: 12.w,
             //   boxFit: BoxFit.cover,
                waitWidget:  Image.asset(
                  AssetsManager.trainerIMG,
                ),
                errorWidget:  Image.asset(
                  AssetsManager.trainerIMG,
                ),
              )
              // Image.asset(
              //   widget.trainer.image,
              //   width: 12.w,
              //   height: 12.w,
              // ),
            ),
          ),
          title: Text(
            'لمى يوسف',
          ),
          subtitle: Row(
            children: [
              SvgPicture.asset(AssetsManager.starIMG),
              Text('4.9'),
            ],
          ),
        ),
        Text(
          'ممتازه وشرحها اكثر من رائع ',
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSize.s10,),
                  const Text('تعلمي قيادة السيارة من الصفر',),
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
