import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/models.dart';
import '../../model/utils/const.dart';
import '../utils/firebase.dart';


class DateTrainerProvider extends ChangeNotifier{

  DateTrainer dateTrainer= DateTrainer.init();
  DateTrainers dateTrainers=DateTrainers(listDateTrainer: []);

  addDateTrainer(context,{ required DateTrainer dateTrainer}) async {
    var result;
    result =await FirebaseFun.addDateTrainer(dateTrainer: dateTrainer);
    //print(result);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
       return result;
  }
  updateDateTrainer(context,{ required DateTrainer dateTrainer}) async {
    var result;
    result =await FirebaseFun.updateDateTrainer(dateTrainer: dateTrainer);
    //print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  deleteDateTrainer(context,{ required DateTrainer dateTrainer}) async {
    var result;
    result =await FirebaseFun.deleteDateTrainer(dateTrainer: dateTrainer);
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