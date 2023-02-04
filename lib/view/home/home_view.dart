import 'dart:async';

import 'package:pinkey/view/manager/widgets/button_app.dart';
import 'package:pinkey/view/manager/widgets/textformfiled_app.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/triner_details/trainer_details_view.dart';
import 'package:intl/intl.dart';

import '../../model/models.dart';
import '../notifications/notifications_view.dart';

import '/view/manager/widgets/ShadowContainer.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/style_manager.dart';
import '/view/resourse/values_manager.dart';

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
    Trainer(image: 'assets/images/1.png',
        name: 'عبير عبد الغني',
        type_of_work_permit: 'رخصة عمل حر',
        location: 'مكة, حي الشوقية,',
        rate: 4.9,
        isFav: true
    ),
    Trainer(image: 'assets/images/2.png',
        name: 'نهي منير',
        type_of_work_permit: '',
        location: 'مكة, النواريه',
        rate: 4.9,
        isFav: false
    ),
    Trainer(image: 'assets/images/3.png',
        name: 'نور رحمة',
        type_of_work_permit: 'رخصة عمل حر',
        location: 'مكة, العزيزية',
        rate: 4.9,
        isFav: false
    ),
  ];
  final searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
     ListTile(
       contentPadding: EdgeInsets.zero,
       title:  Text(AppStringsManager.home,style: getRegularStyle(
           color: Colors.black,
           fontSize: 16.sp
       ),),
       trailing: InkWell(
           onTap: (){
             Get.to(()=>NotificationView(),
             transition: Transition.leftToRightWithFade
             );
           },
           child: SvgPicture.asset(AssetsManager.notficationIMG)),
     ),
        Row(
          children: [
            SvgPicture.asset(AssetsManager.locationIMG),
            Expanded(
              child: DropdownButtonFormField(
                icon: Icon(Icons.keyboard_arrow_down,size: 14.sp,),
                  style: getRegularStyle(color: ColorManager.black,fontSize: 10.sp),
                  items: [
               for(int i = 0 ; i < 10 ; i++)
                 DropdownMenuItem(
                   child: Text('مكة , الزاهر ، حي الشهداء${i+1}',
                     style: getRegularStyle(color: ColorManager.black,
                     fontSize: 10.sp
                     ),),
                   value: i,
                 )

              ],
                  decoration: InputDecoration(
                    hintStyle: getRegularStyle(color: ColorManager.black,fontSize: 10.sp),
                    contentPadding: EdgeInsets.zero,
                    hintText: AppStringsManager.select_location,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    filled: false
                  ),
                  onChanged: (value){
                print(value);
              }),
            ),
            Expanded(child: SizedBox())
          ],
        ),
        const SizedBox(height: AppSize.s10,),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: SvgPicture.asset(AssetsManager.search_iconIMG),
            ),
            hintText: AppStringsManager.search_trainer,
            hintStyle: getRegularStyle(color: ColorManager.hintColor,
            fontSize: 12.sp,
            )
          ),
        ),
        const SizedBox(height: AppSize.s10,),
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
        ListTile(
          contentPadding: EdgeInsets.zero,
          title:  Text(AppStringsManager.all_trainer,style: getRegularStyle(
              color: Colors.black,
              fontSize: 16.sp
          ),),
        ),
        const SizedBox(height: AppSize.s10,),
        for(int i = 0 ; i <_trainerList.length;i++ )
          BuildTrainerItem(trainer: _trainerList[i],)


      ],
    );
  }
}

class BuildTrainerItem extends StatefulWidget {
  final Trainer trainer;

  const BuildTrainerItem({super.key, required this.trainer});

  @override
  State<BuildTrainerItem> createState() => _BuildTrainerItemState();
}

class _BuildTrainerItemState extends State<BuildTrainerItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          margin:  const EdgeInsets.symmetric(vertical: AppPadding.p4),
          decoration: BoxDecoration(
            color: ColorManager.white,
          border: Border.all(color: ColorManager.borderColor),
            borderRadius: BorderRadius.circular(6.sp)
          ),
          child: Row(
            children: [
              Expanded(child:  Image.asset(widget.trainer.image,width: 100.sp,height: 100.sp,),),
              Expanded(flex:2,child:  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(widget.trainer.name,style: getRegularStyle(color: ColorManager.black),),
                  const SizedBox(height: AppSize.s6,),
                  Text(widget.trainer.type_of_work_permit,style: getRegularStyle(color: ColorManager.black,
                  fontSize: 10.sp),),
                  const SizedBox(height: AppSize.s6,),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManager.locationIMG),
                      Text(widget.trainer.location,
                        style: getRegularStyle(color: ColorManager.lightGray,
                          fontSize: 10.sp),),

                    ],
                  ),
                  const SizedBox(height: AppSize.s20,),
                  Row(
                    children: [
                      Expanded(
                        flex:4,
                        child: ButtonApp(
                          height: AppSize.s40,
                            fontSize: 12.sp,
                            text: AppStringsManager.show_trainer_details, onPressed: (){

                              Get.to(()=> TrainerDetailsView(
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
              const Icon(Icons.star,color: Colors.amberAccent,),
              const SizedBox(width: AppSize.s4,),
              Text('${widget.trainer.rate}'),
            ],
          ),
        ),
      ],
    );
  }
}
