import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '/controller/provider/profile_provider.dart';
import '/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';


import '../../model/models.dart';
import '../../model/utils/const.dart';


import '../utils/firebase.dart';
import 'dart:math' as Math;
class WalletProvider with ChangeNotifier{
  Wallet wallet=Wallet.init();
 WalletChange walletChange=WalletChange.init();
 String idAdmin='KNcPHYfrSUVeF74yeQo2';
 String idWalletAdmin='1kSOo4IHEch4AZY0kfvW';
 num parseAdmin=0.15;
 fetchMyWallet(BuildContext context) async {
  ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
   var result;
     result= await fetchWalletByIdUser(context, idUser: profileProvider.user.id);
     if(result['status']){
       if(result['body'].length<=0){
         wallet=Wallet(idUser: profileProvider.user.id,listWalletChange: []);
         result= await addWallet(context, wallet: wallet);
       }
       else{
         wallet=Wallet.fromJson(result['body'][0]);
         wallet.id=result['body'][0].id;
       }
     }
   return result;

 }
 fetchWalletByIdUser(BuildContext context,{required idUser}) async {
   var result;
     result=await FirebaseFun.fetchWalletByIdUser(idUser: idUser);
   return result;
 }
 addWallet(BuildContext context,{required Wallet wallet}) async {
   var result;
     result=await FirebaseFun.addWallet(wallet: wallet);
   return result;

 }
 addBalanceToWallet(BuildContext context,{required num balance}) async {
   walletChange=WalletChange(idUser: wallet.idUser, change: AppStringsManager.add_balance, dateTime: DateTime.now(),value: balance);
   wallet.listWalletChange.add(walletChange);
   wallet.value+=balance;
   var result;
     result=await FirebaseFun.updateWallet(wallet: wallet);
     if(result['status']){
       Const.TOAST(context,textToast:AppStringsManager.done_add_balance);
     }else{
       wallet.listWalletChange.remove(walletChange);
       wallet.value-=balance;
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     }
     notifyListeners();
   return result;

 }
 updateWallet(BuildContext context,{required Wallet wallet}) async {
   var result;
     result=await FirebaseFun.updateWallet(wallet: wallet);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;

 }
 addWalletToAdmin(BuildContext context,{required num value,required String change}) async {
   var result=await await addBalanceToUser(context, idUser: idAdmin, value: value*parseAdmin, change: change);

   return result;
 }
  addBalanceToUser(BuildContext context,{required idUser,required num value,required String change}) async {
    var result=await fetchWalletByIdUser(context,idUser: idUser);
    if(result['status']&&result['body'].length>0){
      Wallet walletUser=Wallet.fromJson(result['body'][0]);
      walletUser.id=result['body'][0].id;
      walletUser.value+=value;
      walletUser.listWalletChange.add(WalletChange(idUser: wallet.idUser,
          value: value,
          change: '${AppStringsManager.add_credit}'+' '+'${change}', dateTime: DateTime.now()));
      result =await updateWallet(context,wallet: walletUser);
    }
    return result;
  }
}
