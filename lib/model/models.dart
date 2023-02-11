import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  TrainerInfo? trainerInfo;
  String location;
  num disKm;
  num latitude;
  num longitude;
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
    this.trainerInfo,
    this.disKm=0,
    this.latitude=0,
    this.longitude=0,
    this.location='',

  });

  factory User.fromJson(json) {
    var data;
    if(Map<String,dynamic>().runtimeType!=json.runtimeType)
       data=json.data();
    else
      data=json;
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
        trainerInfo: (data['trainerInfo']!=null)?TrainerInfo.fromJson(json["trainerInfo"]):null,
        // tokens: json["tokens"],
        description: (data['description']!=null) ? json["description"] : "",
        wallet: (data['wallet']!=null) ? json["wallet"] : 0,
      disKm: json['disKm'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],

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
    'trainerInfo': (trainerInfo!=null)?trainerInfo?.toJson():null,
    'disKm': disKm,
    'latitude': latitude,
    'longitude': longitude,
    'location': location,

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

//TrainerInfo
class TrainerInfo {
  String nationality;
  String city;
  String neighborhood;
  String idNumber;
  String cvUrl;
  String idLicence;
  String haveCar;
  String workInDrivingSchools;
  String trainedFemaleStudents;
  String priceInHerCar;
  String priceInYourCar;
  String numberOfHour;
  String imageIDFileUrl;
  String carLicenceFileUrl;
  String carRegistrationFileUrl;
  String carImageFileUrl;
  String selfEmploymentLicenseFileUrl;
  String otherImageFileUrl;
  String typeOfWork;


  TrainerInfo({
    required this.nationality,
    required this.city,
    required this.neighborhood,
    required this.idNumber,
    required this.cvUrl,
    required this.idLicence,
    required this.haveCar,
    required this.workInDrivingSchools,
    required this.trainedFemaleStudents,
    required this.priceInHerCar,
    required this.priceInYourCar,
    required this.numberOfHour,
    required this.imageIDFileUrl,
    required this.carLicenceFileUrl,
    required this.carRegistrationFileUrl,
    required this.carImageFileUrl,
    required this.selfEmploymentLicenseFileUrl,
    required this.otherImageFileUrl,
     this.typeOfWork='رخصة عمل حر',

  });

  factory TrainerInfo.fromJson(json) {
    //print(json);
    return TrainerInfo(
      nationality: json['nationality'],
      city: json['city'],
      neighborhood: json['neighborhood'],
      idNumber: json['idNumber'],
      cvUrl: json['cvUrl'],
      idLicence: json['idLicence'],
      haveCar: json['haveCar'],
      workInDrivingSchools: json['workInDrivingSchools'],
      trainedFemaleStudents: json['trainedFemaleStudents'],
      priceInHerCar: json['priceInHerCar'],
      priceInYourCar: json['priceInYourCar'],
      numberOfHour: json['numberOfHour'],
      imageIDFileUrl: json['imageIDFileUrl'],
      carLicenceFileUrl: json['carLicenceFileUrl'],
      carRegistrationFileUrl: json['carRegistrationFileUrl'],
      carImageFileUrl: json['carImageFileUrl'],
      selfEmploymentLicenseFileUrl: json['selfEmploymentLicenseFileUrl'],
      otherImageFileUrl: json['otherImageFileUrl'],
      typeOfWork: json['typeOfWork'],



    );
  }
  factory TrainerInfo.init(){
    return TrainerInfo(nationality: '', city: '', neighborhood: '', idNumber: '', cvUrl: '',
        idLicence: '', haveCar: '', workInDrivingSchools: '', trainedFemaleStudents: '',
        priceInHerCar: '', priceInYourCar: '', numberOfHour: '', imageIDFileUrl: '',
        carLicenceFileUrl: '', carRegistrationFileUrl: '', carImageFileUrl: '',
        selfEmploymentLicenseFileUrl: '', otherImageFileUrl: '');
  }

  Map<String, dynamic> toJson() => {
    'nationality': nationality,
    'city': city,
    'neighborhood': neighborhood,
    'idNumber': idNumber,
    'cvUrl': cvUrl,
    'idLicence': idLicence,
    'haveCar': haveCar,
    'workInDrivingSchools': workInDrivingSchools,
    'trainedFemaleStudents': trainedFemaleStudents,
    'priceInHerCar': priceInHerCar,
    'priceInYourCar': priceInYourCar,
    'numberOfHour': numberOfHour,
    'imageIDFileUrl': imageIDFileUrl,
    'carLicenceFileUrl': carLicenceFileUrl,
    'carRegistrationFileUrl': carRegistrationFileUrl,
    'carImageFileUrl': carImageFileUrl,
    'selfEmploymentLicenseFileUrl': selfEmploymentLicenseFileUrl,
    'otherImageFileUrl': otherImageFileUrl,
    'typeOfWork': typeOfWork,

  };
}

//WalletChange
class WalletChange {
  String id;
  String idUser;
  String idChange;
  String change;
  num value;
  DateTime dateTime;
  bool notification;

  WalletChange({
    this.id="",
    required this.idUser,
     this.idChange='',
     this.value=0,
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
        value: json['value'],
        notification: json['notification'],
        dateTime: json['dateTime'].toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'idChange': idChange,
      'change': change,
      'value': value,
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
     required this.listWalletChange});

  factory Wallet.fromJson(json) {
    List<WalletChange> temp = [];
    for (int i = 0; i < json['listWalletChange'].length; i++) {
      WalletChange tempElement = WalletChange.fromJson(json['listWalletChange'][i]);
      temp.add(tempElement);
    }
    return Wallet(
        id: (json['id']=='')?json.id:json['id'],
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
  factory Wallet.init()=>Wallet(idUser: '',listWalletChange: []);
}


//Report
class Report {
  String id;
  String idUser;
  String numReport;
  String details;
  String replay;
  DateTime dateTime;
  bool notificationAdmin;
  bool notificationUser;
  Report({
    this.id="",
     this.idUser='',
     this.numReport='',
     this.replay='',
    required this.details,
    required this.dateTime,
     this.notificationUser=false,
     this.notificationAdmin=false,
  });

  factory Report.fromJson(json) {
    return Report(
        id: json['id'],
        idUser: json['idUser'],
        details: json['details'],
        numReport: json['numReport'],
        replay: json['replay'],
        notificationAdmin: json['notificationAdmin'],
        notificationUser: json['notificationUser'],
        dateTime: json['dateTime'].toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'details': details,
      'replay': replay,
      'numReport': numReport,
      'notificationUser': notificationUser,
      'notificationAdmin': notificationAdmin,
      'dateTime': dateTime,
    };
  }
  factory Report.init(){
    return Report(idUser: '', numReport: '', details: '', dateTime: DateTime.now());
  }
}

//Reports
class Reports {

  List<Report> listReport;

  //DateTime date;
  Reports({
    required this.listReport});

  factory Reports.fromJson(json) {
    List<Report> temp = [];
    for (int i = 0; i < json.length; i++) {
      Report tempElement = Report.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Reports(
        listReport: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listReport) {
      temp.add(element.toJson());
    }
    return {
      'listReport': temp,
    };
  }
  factory Reports.init()=>Reports(listReport: []);
}

//DateTrainer
class DateTrainer {
  String id;
  String idTrainer;
  TimeOfDay? from;
  TimeOfDay? to;
  DateTime dateTime;
  String? day;
  DateTrainer({
    this.id="",
    required this.idTrainer,
    required this.from,
    required this.to,
    required this.dateTime,
    required this.day,
  });

  factory DateTrainer.fromJson(json) {
    return DateTrainer(
      id: json['id'],
      idTrainer: json['idTrainer'],
      dateTime: json['dateTime'].toDate(),
      day: json['day'],
      from: (json["from"]==null)?json["from"]: TimeOfDay.fromDateTime(json["from"].toDate()),
      to: (json["to"]==null)?json["to"]:TimeOfDay.fromDateTime(json["to"].toDate()),);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'idTrainer': idTrainer,
    'dateTime': Timestamp.fromDate(dateTime),
    'day': day,
    'from': (from==null)?from:DateTime(dateTime.year,dateTime.month,dateTime.day,from!.hour,from!.minute),
    // 'from': (from==null)?from:DateTime.fromMillisecondsSinceEpoch(((from!.hour-3)*60+from!.minute)*60000),
    'to': (to==null)?to:DateTime(dateTime.year,dateTime.month,dateTime.day,to!.hour,to!.minute),
  };
  factory DateTrainer.init()=>
      DateTrainer(idTrainer: '', from: TimeOfDay.now(), to: TimeOfDay.now(), dateTime: DateTime.now(), day: '');
}
//DateTrainers
class DateTrainers {
  List<DateTrainer> listDateTrainer;

  //DateTime date;

  DateTrainers({required this.listDateTrainer});

  factory DateTrainers.fromJson(json) {
    List<DateTrainer> temp = [];
    for (int i = 0; i < json.length; i++) {
      DateTrainer tempElement = DateTrainer.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return DateTrainers(listDateTrainer: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listDateTrainer) {
      temp.add(element.toJson());
    }
    return {
      'listDateTrainer': temp,
    };
  }
}

//Course
class Course {
  String id;
  String idTrainer;
  TimeOfDay? from;
  TimeOfDay? to;
  DateTime dateTime;
  String category;
  String name;
  num? durationInDays;
  num? priceInTrainerCar;
  num? priceInPersonalCar;
  String description;
  String state;
  Course({
    this.id="",
    required this.idTrainer,
    required this.from,
    required this.to,
    required this.dateTime,
    required this.category,
    required this.name,
     this.durationInDays,
     this.priceInTrainerCar,
     this.priceInPersonalCar,
    required this.description,
     this.state='new',

  });

  factory Course.fromJson(json) {
    return Course(
        id: json['id'],
      idTrainer: json['idTrainer'],
      category: json['category'],
      name: json['name'],
      durationInDays: json['durationInDays'],
      priceInTrainerCar: json['priceInTrainerCar'],
      priceInPersonalCar: json['priceInPersonalCar'],
      description: json['description'],
      state: json['state'],
      dateTime: json['dateTime'].toDate(),
      from: (json["from"]==null)?json["from"]: TimeOfDay.fromDateTime(json["from"].toDate()),
      to: (json["to"]==null)?json["to"]:TimeOfDay.fromDateTime(json["to"].toDate()),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idTrainer': idTrainer,
      'description': description,
      'priceInPersonalCar': priceInPersonalCar,
      'priceInTrainerCar': priceInTrainerCar,
      'durationInDays': durationInDays,
      'name': name,
      'state': state,
      'category': category,
      'dateTime': Timestamp.fromDate(dateTime),
      'from': (from==null)?from:DateTime(dateTime.year,dateTime.month,dateTime.day,from!.hour,from!.minute),
      'to': (to==null)?to:DateTime(dateTime.year,dateTime.month,dateTime.day,to!.hour,to!.minute),
    };
  }
  factory Course.init(){
    return Course(idTrainer:'', from: null, to: null, dateTime: DateTime.now(), category: '',
        name: '',
        description: '');
  }
}

//Courses
class Courses {

  List<Course> listCourse;

  //DateTime date;
  Courses({
    required this.listCourse});

  factory Courses.fromJson(json) {
    List<Course> temp = [];
    for (int i = 0; i < json.length; i++) {
      Course tempElement = Course.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Courses(
        listCourse: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listCourse) {
      temp.add(element.toJson());
    }
    return {
      'listCourse': temp,
    };
  }
  factory Courses.init()=>Courses(listCourse: []);
}

/*
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
