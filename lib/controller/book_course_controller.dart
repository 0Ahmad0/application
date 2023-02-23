import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinkey/controller/provider/book_course_provider.dart';
import 'package:pinkey/controller/provider/wallet_provider.dart';
import 'package:pinkey/model/utils/consts_manager.dart';
import '../view/manager/widgets/confirm_dialog.dart';
import '/controller/provider/course_provider.dart';
import '/controller/provider/date_trainer_provider.dart';
import '/controller/provider/profile_provider.dart';
import '/controller/utils/firebase.dart';
import '/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';

class BookCourseController{
  late BookCourseProvider bookCourseProvider;
  late CourseProvider courseProvider;
  var context;
  List<TimeOfDay> listTimeOfDay=[];
  List<DateTime> listDateTime=[];
  BookCourseController({required this.context}){
    bookCourseProvider= Provider.of<BookCourseProvider>(context);
    courseProvider= Provider.of<CourseProvider>(context);
  }
  fetchBookCourses(BuildContext context) async {
    ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
    var result;
    if(AppConstants.collectionTrainer.contains(profileProvider.user.typeUser)){
      result= await FirebaseFun.fetchBookCourseByFieldOrderBy(field: 'idTrainer', value: profileProvider.user.id);
    }else{
      result= await FirebaseFun.fetchBookCourseByFieldOrderBy(field: 'idUser', value: profileProvider.user.id);
    }

    if(result['status']){
      bookCourseProvider.bookCourses=BookCourses.fromJson(result['body']);
      bookCourseProvider.bookCourses.listBookCourse=await processCourse(bookCourseProvider.bookCourses.listBookCourse);
    }else{
      Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    }
    return result;
  }

  processCourse(List<BookCourse> listBookCourse) async {
    List<BookCourse> listTemp=[];
    for(BookCourse bookCourse in listBookCourse){
       if(compareDateYMD(dateTime1: bookCourse.listDateTime.last,dateTime2: DateTime.now())<0){
         if(bookCourse.checkState)
         bookCourse.state=AppStringsManager.completed;
         else
           bookCourse.state=AppStringsManager.cancelled;
       }
       await courseProvider.fetchCourseFromMap(idCourse: bookCourse.idCourse);
       if(courseProvider.mapCourses[bookCourse.idCourse]!=null)
       listTemp.add(bookCourse);
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
  getDatesAndHours(){
    listTimeOfDay=partDateDayToListHours(from: courseProvider.course.from!, to: courseProvider.course.to!);
    listDateTime=partDateTimeToListDate(dateTime: courseProvider.course.dateTime, durationDay: courseProvider.course.durationInDays!);
  }
  partDateDayToListHours({required TimeOfDay from, required TimeOfDay to}){
    List<TimeOfDay> listHour=[];
    if(from==null)
      return listHour;
    for(TimeOfDay i=from!;i.hour<to!.hour;i=TimeOfDay(hour: i.hour+1, minute: i.minute)){
      listHour.add(i);

    }

    return listHour;
  }
  partDateTimeToListDate({required DateTime dateTime, required num durationDay}){
    List<DateTime> listDate=[];

    for(int i=0;i<durationDay;i++){
      DateTime dateTime1=DateTime(dateTime.year,dateTime.month,dateTime.day+i);
      listDate.add(dateTime1);

    }

    return listDate;
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
  validBookCourse(context,BookCourse bookCourse){
    WalletProvider walletProvider=Provider.of<WalletProvider>(context,listen: false);
    if(walletProvider.wallet.value<bookCourse.price)
      return false;
    return true;
  }
  addBookCourse(context) async {
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context,listen: false);
    WalletProvider walletProvider= Provider.of<WalletProvider>(context,listen: false);
    bookCourseProvider.bookCourse.idUser=profileProvider.user.id;
    bookCourseProvider.bookCourse.idTrainer=courseProvider.course.idTrainer;
    bookCourseProvider.bookCourse.idCourse=courseProvider.course.id;
    bookCourseProvider.bookCourse.dateTime=DateTime.now();
    Const.LOADIG(context);
    var result;
     if(validBookCourse(context,bookCourseProvider.bookCourse)){
       result=await bookCourseProvider.addBookCourse(context,bookCourse: bookCourseProvider.bookCourse);
       if(result['status']){
         WalletChange walletChange=WalletChange(idUser: profileProvider.user.id,
             change: '${AppStringsManager.balance_deduction}'+' '+'${bookCourseProvider.bookCourse.price}'+' '+'${AppStringsManager.to_book_course}',
             dateTime: DateTime.now());
         walletProvider.wallet.listWalletChange.add(walletChange);
         walletProvider.wallet.value-=bookCourseProvider.bookCourse.price;
         final resultWallet=await walletProvider.updateWallet(context, wallet: walletProvider.wallet);
         if(!resultWallet['status']){
           walletProvider.wallet.listWalletChange.remove(walletChange);
           walletProvider.wallet.value+=bookCourseProvider.bookCourse.price;
         }
       }

     }
     else{
       result=await FirebaseFun.errorUser(AppStringsManager.not_enough_money_wallet);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     }
    Get.back();
    if(result['status'])
        {
          Get.off(()=>NavbarView());
          showBookingConfirmDialog(context);
        }
    return result;
  }
  updateBookCourse(context,{ required BookCourse bookCourse}) async {
    Const.LOADIG(context);
    var result=await bookCourseProvider.updateBookCourse(context,bookCourse: bookCourse);
    Get.back();
    if(result['status']){
      Get.back();
      Get.back();
    }

    return result;
  }
  acceptBookCourse(context,{ required BookCourse bookCourse}) async {
    Const.LOADIG(context);
    ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
    bookCourse.checkState=true;
    bookCourse.idUserState=profileProvider.user.id;
    var result=await bookCourseProvider.updateBookCourse(context,bookCourse: bookCourse);
    Get.back();
    if(result['status']){
      bookCourseProvider.notifyListeners();

    }

    return result;
  }
  cancelBookCourse(context,{ required BookCourse bookCourse}) async {
    Const.LOADIG(context);
    ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
    bookCourse.state=AppStringsManager.cancelled;
    bookCourse.idUserState=profileProvider.user.id;
    var result=await bookCourseProvider.updateBookCourse(context,bookCourse: bookCourse);
    Get.back();
    if(result['status']){
      bookCourseProvider.notifyListeners();

    }

    return result;
  }
  deleteBookCourse(context,{ required BookCourse bookCourse}) async {
    Const.LOADIG(context);
    await bookCourseProvider.deleteBookCourse(context,bookCourse: bookCourse);
    Get.back();
  }
  convertNumberDayForNameDay({required int numberDay, required BuildContext context}){
    final date = DateTime.now().add(Duration(days: numberDay));
    final _dayFormatter = DateFormat('EEEE', context.locale.toString());
    return _dayFormatter.format(date).toLocale().toString();
  }
}