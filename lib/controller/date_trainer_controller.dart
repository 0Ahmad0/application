import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinkey/controller/provider/date_trainer_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';

class DateTrainerController{
  late DateTrainerProvider dateTrainerProvider;
  var context;
  DateTrainerController({required this.context}){
    dateTrainerProvider= Provider.of<DateTrainerProvider>(context);
  }
  processDateTrainer(List<DateTrainer> listDateTrainer){
    List<DateTrainer> listTemp=[];
    return listTemp;
  }
  // addOrUpdateDateTrainer(BuildContext context,{ required Map<String, dynamic> dateLawyerController}) async {
  //   ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
  //   DateLawyer dateLawyer =DateLawyer(dateDays: {}, idLawyer: profileProvider.user.id,id: dateLawyerProvider.dateLawyer.id);
  //
  //   for(var key in dateLawyerController.keys){
  //     DateDay dateDay=DateDay(from: null, to: null);
  //     if(dateLawyerController[key]['to'].text!=''){
  //       dateDay.to=stringToTimeOfDay(dateLawyerController[key]['to'].text);
  //       dateDay.from=stringToTimeOfDay(dateLawyerController[key]['from'].text);
  //     }
  //
  //     // {
  //      if((dateDay.to != null&&dateDay.from !=null)
  //      &&(dateDay.to!.hour*60+dateDay.to!.minute)<=(dateDay.from!.hour*60+dateDay.from!.minute+60)) {
  //
  //        print('${ dateDay.to!.hour*60+dateDay.to!.minute} ${ dateDay.from!.hour*60+dateDay.from!.minute+60} ');
  //        print('${ dateDay.from} ${ dateDay.from!.hour} ${ dateDay.from!.hourOfPeriod} ${ dateDay.from!.period}');
  //        print('${ dateDay.to} ${ dateDay.to!.hour} ${ dateDay.to!.hourOfPeriod} ${ dateDay.to!.period}');
  //           String nameDay=convertNumberDayForNameDay(numberDay: int.parse(key), context: context);
  //          var result=await FirebaseFun.errorUser("${nameDay}: ${tr(LocaleKeys.start_time_great_end_time)}");
  //          Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
  //          return result;
  //      }
  //     dateLawyer.dateDays[key]=dateDay;
  //   }
  //   if(dateLawyerProvider.dateLawyer.dateDays.length<=0)
  //     return await addDateLawyer(context, dateLawyer: dateLawyer);
  //   else
  //    return await updateDateLawyer(context, dateLawyer: dateLawyer);
  // }
  //
  TimeOfDay stringToTimeOfDay(String time) {
    // final format = DateFormat.jm(); //"6:00 AM"
    // return TimeOfDay.fromDateTime(format.parse(tod));
    int hh = 0;
    if (time.toLowerCase().endsWith('pm')||time.endsWith('م')) hh = 12;
    time = time.split(' ')[0];

    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]) % 24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }
  // validDateTrainer(DateTrainer dateTrainer){
  //   for(DateTrainer element in dateTrainerProvider.dateTrainers.listDateTrainer){
  //     if(dateTrainer.dateTime.compareTo(element.dateTime)==1){
  //       if((dateTrainer.to!.hour*60+dateTrainer.to!.minute)<=(dateTrainer.from!.hour*60+dateTrainer.from!.minute+60)){
  //         if(((dateTrainer.to!.hour*60+dateTrainer.to!.minute)<(element.to!.hour*60+element.to!.minute)
  //           &&(dateTrainer.to!.hour*60+dateTrainer.to!.minute)>(element.to!.hour*60+element.to!.minute))
  //           ||())
  //       }
  //     }
  //   }
  //}
  addDateTrainer(context,{ required DateTrainer dateTrainer}) async {
    Const.LOADIG(context);
    var result=await dateTrainerProvider.addDateTrainer(context,dateTrainer: dateTrainer);
    Get.back();
    if(result['status'])
        Get.back();
    return result;
    // if(result['status'])
    // Get.off(NavbarView());
  }
  updateDateTrainer(context,{ required DateTrainer dateTrainer}) async {
    Const.LOADIG(context);
    var result=await dateTrainerProvider.updateDateTrainer(context,dateTrainer: dateTrainer);
    Get.back();
    if(result['status'])
      Get.back();
    return result;
  }
  deleteDateLawyer(context,{ required DateTrainer dateTrainer}) async {
    Const.LOADIG(context);
    await dateTrainerProvider.deleteDateTrainer(context,dateTrainer: dateTrainer);
    Get.back();
  }
  convertNumberDayForNameDay({required int numberDay, required BuildContext context}){
    final date = DateTime.now().add(Duration(days: numberDay));
    final _dayFormatter = DateFormat('EEEE', context.locale.toString());
    return _dayFormatter.format(date).toLocale().toString();
  }
}