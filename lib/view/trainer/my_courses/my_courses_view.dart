import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinkey/view/manager/widgets/button_app.dart';
import 'package:pinkey/view/manager/widgets/textformfiled_app.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/trainer/add_new_course/add_new_course_view.dart';
import 'package:pinkey/view/triner_details/trainer_details_view.dart';
import 'package:provider/provider.dart';

import '../../../controller/course_controller.dart';
import '../../../controller/provider/course_provider.dart';
import '../../../controller/provider/profile_provider.dart';
import '../../../model/models.dart';
import '../../../model/utils/const.dart';
import '../../../model/utils/consts_manager.dart';
import '../../app/picture/cach_picture_widget.dart';
import '../../manager/widgets/container_icons.dart';
import '/view/manager/widgets/ShadowContainer.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/style_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MyCoursesView extends StatefulWidget {
  @override
  State<MyCoursesView> createState() => _HomeViewState();
}

class _HomeViewState extends State<MyCoursesView> {
  bool showDetails = false;
  bool isShow = false;
  int _selectedIndex = 0;
  List<Trainer> _trainerList = [
    Trainer(image: 'assets/images/1.png',
        name: 'عبير عبد الغني',
        type_of_work_permit: 'رخصة عمل حر',
        location: 'جدة, حي نظار, شارع النور',
        rate: 4.9,
        isFav: true
    ),
    Trainer(image: 'assets/images/2.png',
        name: 'نهي منير',
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

  var getCourse;
  late ProfileProvider profileProvider;
  late CourseController courseController;
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    getCourseFun();
    super.initState();
  }
  getCourseFun()  {
    getCourse = FirebaseFirestore.instance
        .collection(AppConstants.collectionCourse)
        .where('idTrainer',isEqualTo: profileProvider.user.id)
        .snapshots();
    return getCourse;
  }
  @override
  Widget build(BuildContext context) {
    courseController= CourseController(context: context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          courseController.courseProvider.course=Course.init();
          Get.to(()=>AddNewCourseView(add: true,));
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppPadding.p16),
        children: [
          ChangeNotifierProvider<ProfileProvider>.value(
            value: Provider.of<ProfileProvider>(context),
            child: Consumer<ProfileProvider>(
              builder: (context, profileProvider, child)=>
         ListBody(children: [
           ListTile(
             contentPadding: EdgeInsets.zero,
             title:  Text(AppStringsManager.hello,style: getRegularStyle(
                 color: Colors.black,
                 fontSize: 16.sp
             ),),
             subtitle: Padding(
               padding: const EdgeInsets.only(
                   bottom: AppPadding.p10
               ),
               child: Text('${profileProvider.user.name}',style: getRegularStyle(
                   color: Colors.black,
                   fontSize: 14.sp
               ),),
             ),
             trailing: InkWell(
                 onTap: (){
                   //TODO: notficatrion  do it
                 },
                 child: CircleAvatar(
                   radius: 7.w,
                   backgroundColor: ColorManager.hintColor,
                   child: ClipOval(
                     child:
                     CacheNetworkImage(
                       photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                       '${profileProvider.user.photoUrl}',
                       width: 14.w,
                       height: 14.w,
                       boxFit: BoxFit.cover,
                       waitWidget: Image.asset(
                         AssetsManager.trainerIMG,
                         width: 14.w,
                         height: 14.w,
                       ),
                       errorWidget:Image.asset(
                         AssetsManager.trainerIMG,
                         width: 14.w,
                         height: 14.w,
                       ),
                     )
                     ,
                   ),
                 )),
           ),
           // Row(
           //   children: [
           //     SvgPicture.asset(AssetsManager.locationIMG),
           //     Expanded(
           //       child: DropdownButtonFormField(
           //           icon: Icon(Icons.keyboard_arrow_down,size: 14.sp,),
           //           style: getRegularStyle(color: ColorManager.black,fontSize: 10.sp),
           //           items: [
           //             for(int i = 0 ; i < 10 ; i++)
           //               DropdownMenuItem(
           //                 child: Text('مكة , الزاهر ، حي الشهداء${i+1}',
           //                   style: getRegularStyle(color: ColorManager.black,
           //                       fontSize: 10.sp
           //                   ),),
           //                 value: i,
           //               )
           //
           //           ],
           //           decoration: InputDecoration(
           //               hintStyle: getRegularStyle(color: ColorManager.black,fontSize: 10.sp),
           //               contentPadding: EdgeInsets.zero,
           //               hintText: AppStringsManager.select_location,
           //               border: InputBorder.none,
           //               focusedBorder: InputBorder.none,
           //               enabledBorder: InputBorder.none,
           //               filled: false
           //           ),
           //           onChanged: (value){
           //             print(value);
           //           }),
           //     ),
           //     Expanded(child: SizedBox())
           //   ],
           // ),
           if(profileProvider.user.latitude==0&&profileProvider.user.longitude==0)
           const SizedBox(height: AppSize.s10,),
           // TextFiledApp(iconData: Icons.search_outlined, hintText: AppStringsManager.search_trainer),
           // const SizedBox(height: AppSize.s10,),
           if(profileProvider.user.latitude==0&&profileProvider.user.longitude==0)
           Container(
             padding: const EdgeInsets.all(AppPadding.p14),
             width: double.infinity,
             decoration: BoxDecoration(
                 color: ColorManager.secondaryColor,
                 borderRadius: BorderRadius.circular(6.sp)
             ),
             child: Stack(
               children: [
                 Positioned(
                   left: 0,
                   child: Image.asset(AssetsManager.select_locationIMG,
                     width: 45.w,
                   ),
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                     Text(AppStringsManager.select_your_location,style: getRegularStyle(
                         color: ColorManager.white,
                         fontSize: 14.sp
                     ),),
                     const SizedBox(height: AppSize.s10,),
                     Text(AppStringsManager.you_have_select_location,style: getRegularStyle(
                         color: ColorManager.white
                     ),),
                     const SizedBox(height: AppSize.s10,),
                     SizedBox(
                       height: 6.sp,
                       child: ListView.builder(
                         scrollDirection: Axis.horizontal,
                         itemCount: 3,
                         itemBuilder: (_,index){
                           return InkWell(
                             onTap: (){
                               setState(() {
                                 _selectedIndex = index;
                               });
                             },
                             child: Container(
                               padding: const EdgeInsets.all(AppPadding.p10),
                               margin: const EdgeInsets.only(right: AppMargin.m4),
                               decoration: BoxDecoration(
                                   color: _selectedIndex == index?ColorManager.thirdlyColor:ColorManager.white,
                                   borderRadius: BorderRadius.circular(AppSize.s100)
                               ),
                             ),
                           );
                         },
                       ),
                     )
                   ],
                 ),
               ],
             ),
           ),
         ],),)),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title:  Text(AppStringsManager.my_courses,style: getRegularStyle(
                color: Colors.black,
                fontSize: 16.sp
            ),),
          ),
          const SizedBox(height: AppSize.s10,),
      StreamBuilder<QuerySnapshot>(
        //prints the messages to the screen0
          stream: getCourse,
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

                  courseController.courseProvider.courses=Courses.fromJson(snapshot.data!.docs);
                  courseController.courseProvider.courses.listCourse=courseController.
                  processCourse(courseController.courseProvider.courses.listCourse);
                  //   print(dateTrainerController.dateTrainerProvider.dateTrainers.toJson());
                }else{
                  courseController.courseProvider.courses.listCourse.clear();
                }

                return
                  (courseController.courseProvider.courses.listCourse.length<=0)?
                   SizedBox()
                  :ListBody(children: [
                  for(int i = 0 ; i <courseController.courseProvider.courses.listCourse.length;i++ )
                    BuildTrainerCourseItem(course: courseController.courseProvider.courses.listCourse[i],)
                ]);
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
      ),
    );
  }
}
// buildCourse(){
//   return ListBody(children: [
//     for(int i = 0 ; i <_trainerList.length;i++ )
//          BuildTrainerCourseItem(trainer: _trainerList[i],) ,
//   ]);
//
// }

class BuildTrainerCourseItem extends StatefulWidget {
  final Course course;

  const BuildTrainerCourseItem({super.key, required this.course});

  @override
  State<BuildTrainerCourseItem> createState() => _BuildTrainerCourseItemState();
}

class _BuildTrainerCourseItemState extends State<BuildTrainerCourseItem> {
  bool showDetails = false;
  @override
  Widget build(BuildContext context) {
    final CourseProvider courseProvider = Provider.of<CourseProvider>(context, listen: false);
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
                    SvgPicture.asset(AssetsManager.trainer_course_nameIMG),
                    const SizedBox(
                      width: AppSize.s4,
                    ),
                    const Text(AppStringsManager.trainer_courses_name),
                    const SizedBox(
                      width: AppSize.s4,
                    ),
                    Text(
                      widget.course.name,
                      //'(للمبتدئين)',
                      style: getRegularStyle(color: ColorManager.lightGray),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p30),
                  child: Column(
                    children: [
                      const SizedBox(height: AppSize.s10,),
                       Text(
                        widget.course.category
                        //'هذه المكان مخصص لوضع عنوان مناسب للدورة المقدمة'
                        ,),
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
                                  ?AppStringsManager.hidden_trainer_course_details
                              :AppStringsManager.show_trainer_course_details,
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
                  child: Text(
                    widget.course.description
                  //   ':تهدف الدورة الي\n'
                  // 'إعطاء الطلبات فكرة عامة عن القيادة *\n'
                  // 'تعليم الطالبات أسماء المتحكمات *\n'
                  // 'كيفية تشغيل وإيقاف السيارة *'

                    ,style: getRegularStyle(
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
                      text: 'سيارتي ${widget.course.priceInPersonalCar} ر.س',
                      icon: Icon(
                        Icons.monetization_on,
                        size: 16.sp,
                        color: ColorManager.secondaryColor,
                      )),
                  buildContainerDetailsTrainer(
                      text: 'المتدربة ${widget.course.priceInTrainerCar} ر.س',
                      icon: Icon(
                        Icons.monetization_on,
                        size: 16.sp,
                        color: ColorManager.secondaryColor,
                      )),
                  buildContainerDetailsTrainer(
                      text: '${widget.course.durationInDays} أيام',
                      icon: SvgPicture.asset(
                        AssetsManager.appointmentsIMG,
                        color: ColorManager.secondaryColor,
                        width: 16.sp,
                        height: 16.sp,
                      )),
                ],
              ),


            ],
          ),
        ),
        Positioned(
          left: AppSize.s10,
          top: AppSize.s20,
          child: InkWell(
            onTap: (){
              courseProvider.course=widget.course;
              Get.to(()=>AddNewCourseView(add: false,));
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
          )
        ),
      ],
    );
  }

}
