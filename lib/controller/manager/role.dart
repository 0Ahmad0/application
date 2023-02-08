import 'package:pinkey/model/utils/consts_manager.dart';

class Role{
   static Map mapRole={
     '${AppConstants.collectionVisitor}':[],
     '${AppConstants.collectionUser}':[my_profile,notification],
     '${AppConstants.collectionTrainer}':[my_profile,notification],
     '${AppConstants.collectionAdmin}':[my_profile,notification],
   };
   static List allRole=[
     login,signup,recovery_password
   ];
   static const login='login';
   static const signup='signup';
   static const recovery_password='recovery_password';
   static const my_profile='my_profile';
   static const  notification='notification';
   static checkRole({required String typeUser,required String role}){
     if(allRole.contains(role))
       return true;
     else if(mapRole.containsKey(typeUser)&&mapRole[typeUser].contains(role))
       return true;
     else
       return false;
   }
}