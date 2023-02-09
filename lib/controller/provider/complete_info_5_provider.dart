import 'dart:math';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinkey/controller/provider/process_provider.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:provider/provider.dart';


import '../../model/models.dart';
import '../../model/utils/const.dart';


import '../utils/firebase.dart';
import 'dart:math' as Math;

class CompleteInfo5Provider with ChangeNotifier{
  String imageIDFile='imageIDFile';
  String carLicenceFile='carLicenceFile';
  String carRegistrationFile='carRegistrationFile';
  String carImageFile='carImageFile';
  String selfEmploymentLicenseFile='selfEmploymentLicenseFile';
  String otherImageFile='otherImageFile';
  Map<String,FilePickerResult?> files={};
  dispose(){
    files={};
  }
}
