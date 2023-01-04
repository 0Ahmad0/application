import 'package:flutter/cupertino.dart';

class Meal {
  String name;
  String price;
  List<String> ingredients;

  Meal({required this.name, required this.price, required this.ingredients});
}

class Trainer {
  String image, name, type_of_work_permit, location;
  double rate;
  bool isFav;

  Trainer({
    required this.image,
    required this.name,
    required this.type_of_work_permit,
    required this.location,
    required this.rate,
    required this.isFav,
  });
}
/*
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
