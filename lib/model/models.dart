import 'package:cloud_firestore/cloud_firestore.dart';
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

//advance
class Advance {
  static bool theme = false;
  static bool language = false;
  static bool isRegisterKEY = false;
  static bool isLogined = false;
  static String token = "";
  static String uid = "";
  static String avatarImage = "";
}
//user
class User {
  String id;
  String uid;
  String name;
  String firstName;
  String lastName;
  String photoUrl;
  String email;
  String phoneNumber;
  String password;
  String typeUser;
  String description;
  String gender;
  bool active;
  DateTime dateBirth;
  List<String> tokens;
  num wallet;
  User({
    required this.id,
    required this.uid,
    required this.name,
     this.firstName='',
     this.lastName='',
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.typeUser,
    required this.photoUrl,
    required this.gender,
    required this.dateBirth,
    this.description = "",
    this.active = false,
    this.tokens = const[],
    this.wallet = 0,

  });

  factory User.fromJson(json) {
    //print(json);
    return User(
        id: json['id'],
        uid: json["uid"],
        name: json["name"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        typeUser: json["typeUser"],
        photoUrl: json["photoUrl"],
        gender: json["gender"],
        active: json["active"],
        dateBirth: json["dateBirth"].toDate(),
        // tokens: json["tokens"],
        description: (json["description"] != null) ? json["description"] : "",
        wallet: (json["wallet"] != null) ? json["wallet"] : 0

    );
  }
  factory User.init(){
    return User(id: "", uid: '', name: '', email: '', phoneNumber: '', password: '', typeUser: '', photoUrl: "", gender: "", dateBirth: DateTime.now());
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'name': name,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phoneNumber': phoneNumber,
    'password': password,
    'typeUser': typeUser,
    'gender': gender,
    'dateBirth':Timestamp.fromDate(dateBirth),
    'photoUrl': photoUrl,
    'description': description,
    'active': active,
    'tokens': tokens,
    'wallet': wallet,

  };
}
//users
class Users {
  List<User> users;

  //DateTime date;

  Users({required this.users});

  factory Users.fromJson(json) {
    List<User> tempUsers = [];

    for (int i = 0; i < json.length; i++) {
      User tempUser = User.fromJson(json[i]);
      tempUser.id = json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(users: tempUsers);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempUsers = [];
    for (User user in users) {
      tempUsers.add(user.toJson());
    }
    return {
      'users': tempUsers,
    };
  }


}

//WalletChange
class WalletChange {
  String id;
  String idUser;
  String idChange;
  String change;
  DateTime dateTime;
  bool notification;

  WalletChange({
    this.id="",
    required this.idUser,
     this.idChange='',
    required this.change,
    required this.dateTime,
    this.notification=false,
  });

  factory WalletChange.fromJson(json) {
    return WalletChange(
        id: json['id'],
        idUser: json['idUser'],
        idChange: json['idChange'],
        change: json['change'],
        notification: json['notification'],
        dateTime: json['dateTime'].toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'idChange': idChange,
      'change': change,
      'notification': notification,
      'dateTime': dateTime,
    };
  }
  factory WalletChange.init(){
    return WalletChange(idUser: '', change: '', dateTime: DateTime.now());
  }
}

//Wallet
class Wallet {
  String id;
  String idUser;
  num value;
  List<WalletChange> listWalletChange;

  //DateTime date;
  Wallet({
    this.id="",
    this.value=0,
    required this.idUser,
     this.listWalletChange=const []});

  factory Wallet.fromJson(json) {
    List<WalletChange> temp = [];
    for (int i = 0; i < json.length; i++) {
      WalletChange tempElement = WalletChange.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Wallet(
        id: json['id'],
        idUser: json['idUser'],
        value: json['value'],
        listWalletChange: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listWalletChange) {
      temp.add(element.toJson());
    }
    return {
      'id': id,
      'idUser': idUser,
      'value': value,
      'listWalletChange': temp,
    };
  }
  factory Wallet.init()=>Wallet(idUser: '');
}

/*
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
