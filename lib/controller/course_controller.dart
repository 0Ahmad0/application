import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinkey/controller/provider/course_provider.dart';
import 'package:pinkey/controller/provider/date_trainer_provider.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:pinkey/controller/utils/firebase.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';

class CourseController{
  late CourseProvider courseProvider;
  var context;
  CourseController({required this.context}){
    courseProvider= Provider.of<CourseProvider>(context);
  }
  fetchCoursesByTrainer({required String idTrainer}) async {
    final result= await FirebaseFun.fetchCourseByTrainer(idTrainer: idTrainer);
    if(result['status']){
      courseProvider.courses=Courses.fromJson(result['body']);
      courseProvider.courses.listCourse=processCourse(courseProvider.courses.listCourse);
    }else{
      Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    }
    return result;
  }
  processCourse(List<Course> listCourse){
    List<Course> listTemp=[];
    for(Course course in listCourse){
      if(compareDateYMDIncDay(dateTime1: course.dateTime,day:course.durationInDays!, dateTime2: DateTime.now())>=0){
        listTemp.add(course);
      }
    }
    return listTemp;
  }
  compareDateYMDIncDay({required DateTime dateTime1, num day=0,required DateTime dateTime2}){
    if(dateTime1.year>dateTime2.year)
      return 1;
    if(dateTime1.year<dateTime2.year)
      return -1;
    if(dateTime1.month>dateTime2.month)
      return 1;
    if(dateTime1.month<dateTime2.month)
      return -1;
    if(dateTime1.day+day>dateTime2.day)
      return 1;
    if(dateTime1.day+day<dateTime2.day)
      return -1;
    if(dateTime1.day+day==dateTime2.day)
      return 0;

  }
  compareDateYMD({required DateTime dateTime1,required DateTime dateTime2}){
    if(dateTime1.year>dateTime2.year)
      return 1;
    if(dateTime1.year<dateTime2.year)
      return -1;
    if(dateTime1.month>dateTime2.month)
      return 1;
    if(dateTime1.month<dateTime2.month)
      return -1;
    if(dateTime1.day>dateTime2.day)
      return 1;
    if(dateTime1.day<dateTime2.day)
      return -1;
    if(dateTime1.day==dateTime2.day)
      return 0;

  }

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
  validCourse(Course course){

    if((course.to!.hour*60+course.to!.minute)<=(course.from!.hour*60+course.from!.minute+60)){
      return false;
    };
    for(Course element in courseProvider.courses.listCourse){
      if(compareDateYMD(dateTime1:course.dateTime,dateTime2:element.dateTime)==0){

          //وقت الانتهاء المحدد اصغر من وقت انتهاء ما
          if(((course.to!.hour*60+course.to!.minute)<(element.to!.hour*60+element.to!.minute)
              //و وقت الانتهاء المحدد اكبر من وقت نفس وقت البدء
            &&(course.to!.hour*60+course.to!.minute)>(element.from!.hour*60+element.from!.minute))
              //وقت البدء المحدد اصغر من وقت انتهاء ما
            ||((course.from!.hour*60+course.to!.minute)<(element.to!.hour*60+element.to!.minute)
                  //و وقت البدء المحدد اكبر من  نفس وقت البدء
                  &&(course.from!.hour*60+course.from!.minute)>(element.from!.hour*60+element.from!.minute))
          ){
            return false;
          }

      }
    }
    return true;
  }
  addCourse(context,{ required Course course}) async {
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context,listen: false);
    course.idTrainer=profileProvider.user.id;
    Const.LOADIG(context);
    var result;
     if(validCourse(course)){
       result=await courseProvider.addCourse(context,course: course);
     }
     else{
       result=await FirebaseFun.errorUser(AppStringsManager.conflict_date_trainer);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     }
    Get.back();
    if(result['status'])
        {
          Get.back();
          Get.back();
        }
    return result;
    // if(result['status'])
    // Get.off(NavbarView());
  }
  updateCourse(context,{ required Course course}) async {
    Const.LOADIG(context);
    var result=await courseProvider.updateCourse(context,course: course);
    Get.back();
    if(result['status']){
      Get.back();
      Get.back();
    }

    return result;
  }
  deleteCourse(context,{ required Course course}) async {
    Const.LOADIG(context);
    await courseProvider.deleteCourse(context,course: course);
    Get.back();
  }
  convertNumberDayForNameDay({required int numberDay, required BuildContext context}){
    final date = DateTime.now().add(Duration(days: numberDay));
    final _dayFormatter = DateFormat('EEEE', context.locale.toString());
    return _dayFormatter.format(date).toLocale().toString();
  }
}