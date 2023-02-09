import 'dart:math';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinkey/controller/provider/process_provider.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:pinkey/model/utils/consts_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';


import '../../model/models.dart';
import '../../model/utils/const.dart';


import '../utils/firebase.dart';
import 'dart:math' as Math;

class AccountProvider with ChangeNotifier{
 Users trainerRequests=Users(users: []);
 fetchTrainerRequests(BuildContext context) async {
   var result;
     result= await FirebaseFun.fetchUsersByTypeUserAndFieldOrderBy
       (typeUser: AppConstants.collectionTrainer, field: 'active', value: false);
     if(result['status']){
       trainerRequests=Users.fromJson(result['body']);
     }else{
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     }
   return result;
 }
 fetchTrainerRequestsStream(BuildContext context){
   var result;
   result=  FirebaseFirestore.instance.collection(AppConstants.collectionTrainer)
       .where('active',isEqualTo: false)
       .orderBy('dateTime').snapshots();
   return result;
 }

 activeAccount(BuildContext context,{required User user}) async {
   Const.LOADIG(context);
   user.active=true;
   var result;
     result=await FirebaseFun.updateUser(user: user);
   Get.back();
   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;

 }

}
