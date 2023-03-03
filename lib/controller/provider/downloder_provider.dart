

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/models.dart';


class DownloaderProvider with ChangeNotifier{
  Map<String,double> downloadProgress={};
  Map<String,bool> checkClickDownload={};
  Map<String,bool> checkCompleteDownload={};
   late var tempDir;
  Future downloadFile(Message message) async {
    checkClickDownload[message.id]=true;
    checkCompleteDownload[message.id]=false;
    downloadProgress[message.id]=0;
    notifyListeners();
    final tempDir= await getTemporaryDirectory();

    final path = "${tempDir.path}/${message.textMessage}";
    var result =await Dio().download(
        message.url,
        path,
      onReceiveProgress: (received,total){
          double progress=received/total;
          if(received==total){
            checkCompleteDownload[message.id]=true;
            checkClickDownload[message.id]=false;
          }
          downloadProgress[message.id]=progress;
          notifyListeners();
      }
    );
  }

}