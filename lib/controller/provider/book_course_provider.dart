import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/models.dart';
import '../../model/utils/const.dart';
import '../utils/firebase.dart';


class BookCourseProvider extends ChangeNotifier{

  BookCourse bookCourse= BookCourse.init();
  BookCourses bookCourses=BookCourses(listBookCourse: []);

  addBookCourse(context,{ required BookCourse bookCourse}) async {
    var result;
    result =await FirebaseFun.addBookCourse(bookCourse: bookCourse);
    //print(result);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
       return result;
  }
  updateBookCourse(context,{ required BookCourse bookCourse}) async {
    var result;
    result =await FirebaseFun.updateBookCourse(bookCourse: bookCourse);
    //print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  deleteBookCourse(context,{ required BookCourse bookCourse}) async {
    var result;
    result =await FirebaseFun.deleteBookCourse(bookCourse: bookCourse);
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