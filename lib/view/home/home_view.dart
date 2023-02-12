import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as fireStore;
import 'package:flutter/cupertino.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pinkey/controller/manager/role.dart';
import 'package:pinkey/controller/provider/home_provider.dart';
import 'package:pinkey/view/manager/widgets/button_app.dart';
import 'package:pinkey/view/manager/widgets/textformfiled_app.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/triner_details/trainer_details_view.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/profile_provider.dart';
import '../../model/models.dart';
import '../../model/utils/const.dart';
import '../../model/utils/consts_manager.dart';
import '../app/picture/cach_picture_widget.dart';
import '../notifications/notifications_view.dart';

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

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isShow = false;
  int _selectedIndex = 0;
  List<Trainer> _trainerList = [
    Trainer(
        image: 'assets/images/1.png',
        name: 'عبير عبد الغني',
        type_of_work_permit: 'رخصة عمل حر',
        location: 'مكة, حي الشوقية,',
        rate: 4.9,
        isFav: true),
    Trainer(
        image: 'assets/images/2.png',
        name: 'نهي منير',
        type_of_work_permit: '',
        location: 'مكة, النواريه',
        rate: 4.9,
        isFav: false),
    Trainer(
        image: 'assets/images/3.png',
        name: 'نور رحمة',
        type_of_work_permit: 'رخصة عمل حر',
        location: 'مكة, العزيزية',
        rate: 4.9,
        isFav: false),
  ];
  final searchController = TextEditingController();
  final latitudeController = TextEditingController(text: '0');
  final longitudeController = TextEditingController(text: '0');
  final locationController = TextEditingController();
  var getTrainer;
  late ProfileProvider profileProvider;
  late HomeProvider homeProvider;

  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    getTrainerFun();
    super.initState();
  }

  getTrainerFun() {
    getTrainer = homeProvider.fetchTrainerRequestsStream(context);
    return getTrainer;
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
        ChangeNotifierProvider<ProfileProvider>.value(
            value: Provider.of<ProfileProvider>(context),
            child: Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) => ListBody(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      AppStringsManager.home,
                      style:
                          getRegularStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                    trailing: Role.checkRole(
                            typeUser: profileProvider.user.typeUser,
                            role: Role.notification)
                        ? InkWell(
                            onTap: () {
                              Get.to(() => NotificationView(),
                                  transition: Transition.leftToRightWithFade);
                            },
                            child:
                                SvgPicture.asset(AssetsManager.notficationIMG))
                        : SizedBox(),
                  ),
                  if (Role.checkRole(
                      typeUser: profileProvider.user.typeUser,
                      role: Role.location))
                    Row(
                      children: [
                        SvgPicture.asset(AssetsManager.locationIMG),
                        Expanded(
                          child: TextButton.icon(
                            label: FittedBox(child: Text(
                                locationController.text.isEmpty?AppStringsManager.select_location
                                    :locationController.text
                            )),
                            icon: Icon(Icons.keyboard_arrow_down_sharp,
                            color: ColorManager.lightGray,
                              size: 16.sp,
                            ),
                            onPressed: () async {
                              GeoPoint? p = await showSimplePickerLocation(
                                context: context,
                                isDismissible: true,
                                title: AppStringsManager.select_your_location,
                                textConfirmPicker:
                                    AppStringsManager.select_location,
                                initCurrentUserPosition: true,
                              );
                              latitudeController.text = p!.latitude.toString();
                              longitudeController.text = p.longitude.toString();
                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
                                      p.latitude, p.longitude);
                              print(placemarks.first.street);
                              locationController.text =
                                  '${placemarks.first.country}'
                                  ' ${placemarks.first.name}';
                              profileProvider.user.location =
                                  locationController.text;
                              profileProvider.user.latitude = p.latitude;
                              profileProvider.user.longitude = p.longitude;
                              profileProvider.notifyListeners();
                            },
                          ),
                        ),
                        Expanded(child: SizedBox())
                      ],
                    )
                ],
              ),
            )),
        const SizedBox(
          height: AppSize.s10,
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
            homeProvider.notifyListeners();
          },
        ),
        if (Role.checkRole(
            typeUser: profileProvider.user.typeUser, role: Role.location))
          ChangeNotifierProvider<ProfileProvider>.value(
              value: Provider.of<ProfileProvider>(context),
              child: Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) => (profileProvider
                                .user.latitude ==
                            0 &&
                        profileProvider.user.longitude == 0)
                    ? ListBody(
                        children: [
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(AppPadding.p14),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorManager.secondaryColor,
                                borderRadius: BorderRadius.circular(6.sp)),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: Image.asset(
                                    AssetsManager.select_locationIMG,
                                    width: 45.w,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      AppStringsManager.select_your_location,
                                      style: getRegularStyle(
                                          color: ColorManager.white,
                                          fontSize: 14.sp),
                                    ),
                                    const SizedBox(
                                      height: AppSize.s10,
                                    ),
                                    Text(
                                      AppStringsManager
                                          .you_have_select_location,
                                      style: getRegularStyle(
                                          color: ColorManager.white),
                                    ),
                                    const SizedBox(
                                      height: AppSize.s10,
                                    ),
                                    SizedBox(
                                      height: 6.sp,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 3,
                                        itemBuilder: (_, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                _selectedIndex = index;
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(
                                                  AppPadding.p10),
                                              margin: const EdgeInsets.only(
                                                  right: AppMargin.m4),
                                              decoration: BoxDecoration(
                                                  color: _selectedIndex == index
                                                      ? ColorManager
                                                          .thirdlyColor
                                                      : ColorManager.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSize.s100)),
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
                        ],
                      )
                    : SizedBox(),
              )),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            AppStringsManager.all_trainer,
            style: getRegularStyle(color: Colors.black, fontSize: 16.sp),
          ),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        StreamBuilder<fireStore.QuerySnapshot>(
            //prints the messages to the screen0
            stream: getTrainer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Const.SHOWLOADINGINDECATOR();
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return ChangeNotifierProvider<HomeProvider>.value(
                      value: Provider.of<HomeProvider>(context),
                      child: Consumer<HomeProvider>(
                          builder: (context, value, child) {
                        Const.SHOWLOADINGINDECATOR();

                        if (snapshot.data!.docs.length > 0) {
                          homeProvider.trainers =
                              Users.fromJson(snapshot.data!.docs);
                          homeProvider.trainers.users =
                              homeProvider.searchOfficesByName(
                                  searchController.text,
                                  homeProvider.trainers.users);
                          // homeProvider.trainers.users=homeProvider.
                          //processCourse(courseController.courseProvider.courses.listCourse);
                          //   print(dateTrainerController.dateTrainerProvider.dateTrainers.toJson());
                        } //  }else{
                        //    homeProvider.trainers.users.clear();
                        //
                        // }
                        return ListBody(children: [
                          for (int i = 0;
                              i < homeProvider.trainers.users.length;
                              i++)
                            BuildTrainerItem(
                              trainer: homeProvider.trainers.users[i],
                            )
                        ]);
                      }));

                  /// }));
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            })
      ],
    );
  }
}

class BuildTrainerItem extends StatefulWidget {
  final User trainer;

  const BuildTrainerItem({super.key, required this.trainer});

  @override
  State<BuildTrainerItem> createState() => _BuildTrainerItemState();
}

class _BuildTrainerItemState extends State<BuildTrainerItem> {
  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          margin: const EdgeInsets.symmetric(vertical: AppPadding.p4),
          decoration: BoxDecoration(
              color: ColorManager.white,
              border: Border.all(color: ColorManager.borderColor),
              borderRadius: BorderRadius.circular(6.sp)),
          child: Row(
            children: [
              Expanded(
                  child: CacheNetworkImage(
                photoUrl: // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                    '${widget.trainer.photoUrl}',
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
                        widget.trainer.name,
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
                            '${widget.trainer.trainerInfo!.city} - ${widget.trainer.trainerInfo!.neighborhood}',
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
                                height: AppSize.s40,
                                fontSize: 12.sp,
                                text: AppStringsManager.show_trainer_details,
                                onPressed: () {
                                  Get.to(() => TrainerDetailsView(
                                        trainer: widget.trainer,
                                      ));
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
        ),
        Positioned(
          left: AppSize.s10,
          top: AppSize.s20,
          child: Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amberAccent,
              ),
              const SizedBox(
                width: AppSize.s4,
              ),
              Text('4.9'),
            ],
          ),
        ),
      ],
    );
  }
}
