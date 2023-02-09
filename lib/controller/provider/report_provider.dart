import 'dart:math';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinkey/controller/provider/process_provider.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';


import '../../model/models.dart';
import '../../model/utils/const.dart';


import '../utils/firebase.dart';
import 'dart:math' as Math;

class ReportProvider with ChangeNotifier{
  Report report=Report.init();
  Reports reports=Reports.init();
  List<Report> listNewReport=[];
  List<Report> listoldReport=[];
 fetchReports(BuildContext context) async {
   var result;
     result= await FirebaseFun.fetchReports();
     if(result['status']){

       reports=Reports.fromJson(result['body']);
      await processReports(context,listReport: reports.listReport);
     }else{
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     }
   return result;

 }
 processReports(BuildContext context,{required List<Report> listReport}) async {
   ProcessProvider processProvider =Provider.of<ProcessProvider>(context,listen: false);
   listNewReport.clear();
   listoldReport.clear();
   DateTime dateTimeNow=DateTime.now();
   for(Report report in listReport){
     await processProvider.fetchNameUser(context, idUser: report.idUser);
     if(DateFormat.yMd().format(dateTimeNow).contains('${(DateFormat.yMd().format(report.dateTime))}')){
       listNewReport.add(report);
     }else{
       listoldReport.add(report);
     }
   }
 }
 addReport(BuildContext context,{required String details}) async {
   ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
   report=Report(details: details,numReport: genOrderId(),idUser: profileProvider.user.id, dateTime: DateTime.now());
   var result;
     result=await FirebaseFun.addReport(report: report);

   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;

 }
 updateReport(BuildContext context,{required Report report}) async {
   var result;
     result=await FirebaseFun.updateReport(report: report);
   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;

 }
  genOrderId(){
    Random random=Random();
    String orderId='';
    for(int i=0;i<4;i++)
      orderId+='${random.nextInt(10)}';
    return orderId;
  }
}
