import 'dart:math';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '/controller/provider/process_provider.dart';
import '/controller/provider/profile_provider.dart';
import '/model/utils/consts_manager.dart';
import '/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';


import '../../model/models.dart';
import '../../model/utils/const.dart';


import '../utils/firebase.dart';
import 'dart:math' as Math;

class HomeProvider with ChangeNotifier{
 Users trainers=Users(users: []);
 fetchTrainer(BuildContext context) async {
   var result;
     result= await FirebaseFun.fetchUsersByTypeUser
       (AppConstants.collectionTrainer);
     if(result['status']){
       trainers=Users.fromJson(result['body']);
     }else{
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     }
   return result;
 }
 fetchTrainerRequestsStream(BuildContext context){
   var result;
   result=  FirebaseFirestore.instance.collection(AppConstants.collectionTrainer)
   .snapshots();
   return result;
 }
 searchOfficesByName(String  search,List listSearch){
   List trimSearch=search.trim().split(' ');
   List<User> tempListSearch=[];
   for(User heritageElement in listSearch){
     if(heritageElement.name!.toLowerCase().contains(search.toLowerCase())){
       tempListSearch.add(heritageElement);
     }else{
       for(String element in trimSearch){
         if(heritageElement.name!.toLowerCase().contains(element.toLowerCase())){
           if(!tempListSearch.contains(heritageElement))
           tempListSearch.add(heritageElement);
         }
       }
     }
   }
   return tempListSearch;
 }


}
