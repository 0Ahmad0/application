import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '/controller/provider/wallet_provider.dart';
import '/view/login/login_view.dart';

import 'package:provider/provider.dart';

import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';
import 'provider/auth_provider.dart';

class AuthController{
  late AuthProvider authProvider;
  var context;
  AuthController({required this.context}){
    authProvider= Provider.of<AuthProvider>(context);
  }

  visitor() async {
    await authProvider.visitor(context);
    Get.off(()=>NavbarView());
  }
  login(BuildContext context,{required String email,required String password,}) async {
    final WalletProvider walletProvider= Provider.of<WalletProvider>(context,listen: false);
    Const.LOADIG(context);
    authProvider.user.email=email;
    authProvider.user.password=password;
    final result=await authProvider.login(context);
    Get.back();
    if(result['status']){
      await walletProvider.fetchMyWallet(context);
      Get.off(() => NavbarView(),
          transition: Transition.circularReveal);
    }

  }

  signUp(BuildContext context,{required String firstName,required String lastName,required String gender,required DateTime dateBirth,required String email,required String password,required String phoneNumber,required String photoUrl,required String typeUser}) async {
    authProvider.user=User(id: '', uid: '',
        name: '$firstName $lastName',
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber
        , password: password,
        typeUser: typeUser,
        photoUrl: photoUrl,
        gender: gender,

        dateBirth: dateBirth);
    final result=await signUpByUser(context);
    return result;
  }
  signUpByUser(BuildContext context) async {
    final WalletProvider walletProvider= Provider.of<WalletProvider>(context,listen: false);
    Const.LOADIG(context);
    final result=await authProvider.signup(context);
    Get.back();
    if(result['status']){
      await walletProvider.fetchMyWallet(context);
      authProvider.user=User.init();
      Get.off(() => LoginView(),
          transition: Transition.circularReveal);
    }
    return result;
  }

  sendPasswordResetEmail(BuildContext context,{required String email}) async {
    Const.LOADIG(context);
    final result =await authProvider.sendPasswordResetEmail(context, resetEmail: email);
    Navigator.of(context).pop();
    if(result['status']){
      Get.back();
    }
  }
}