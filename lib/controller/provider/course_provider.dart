import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/models.dart';
import '../../model/utils/const.dart';
import '../utils/firebase.dart';


class CourseProvider extends ChangeNotifier{

  Course course= Course.init();
  Courses courses=Courses(listCourse: []);

  addCourse(context,{ required Course course}) async {
    var result;
    result =await FirebaseFun.addCourse(course: course);
    //print(result);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
       return result;
  }
  updateCourse(context,{ required Course course}) async {
    var result;
    result =await FirebaseFun.updateCourse(course: course);
    //print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  deleteCourse(context,{ required Course course}) async {
    var result;
    result =await FirebaseFun.deleteCourse(course: course);
    //print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  // fetchMeals () async {
  //   var result= await FirebaseFun.fetchMeals();
  //   if(result['status']){
  //     listMeals=Meals.fromJson(result['body']);
  //   }
  //   return result;
  // }


}