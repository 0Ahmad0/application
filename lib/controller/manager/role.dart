import 'package:pinkey/model/utils/consts_manager.dart';

class Role{
   static Map mapRole={
     '${AppConstants.collectionVisitor}':[homeView,loginMenu],
     '${AppConstants.collectionUser}':[my_profile,notificationMenu,homeView,complaintMenu,notification],
     '${AppConstants.collectionTrainer}':[my_profile,notificationMenu,trainerAppointmentsView,myCoursesView
      ,complaintMenu],
     '${AppConstants.collectionAdmin}':[my_profile,notificationMenu,adminComplaintsView,
       adminRequestView],
   };
   ///,appointmentsView,requestsView
   static List allRole=[
     login,signup,recovery_password,
     menuView,
   ];
   static const login='login';
   static const signup='signup';
   static const recovery_password='recovery_password';
   //menu
   static const my_profile='my_profile';
   static const  notificationMenu='notificationMenu';
   static const  complaintMenu='complaintMenu';
   static const  loginMenu='loginMenu';
   //navBar
   static const  menuView='menuView';
   static const  homeView='homeView';
   static const  trainerAppointmentsView='trainerAppointmentsView';
   static const  myCoursesView='myCoursesView';
   static const  adminComplaintsView='adminComplaintsView';
   static const  adminRequestView='adminRequestView';
   static const  appointmentsView='appointmentsView';
   static const  requestsView='requestsView';
   //homeView
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