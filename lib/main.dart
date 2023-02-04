import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinkey/view/trainer/add_new_course/add_new_course_view.dart';
import 'package:pinkey/view/trainer/complete_information/complete_information_view.dart';
import 'package:provider/provider.dart';

import '/view/splash/splash_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/view/resourse/theme_manager.dart';
import 'package:sizer/sizer.dart';

import 'controller/provider/auth_provider.dart';
import 'controller/provider/chat_provider.dart';
import 'controller/provider/process_provider.dart';
import 'controller/provider/profile_provider.dart';
import 'controller/utils/create_environment_provider.dart';
import 'firebase_options.dart';
import 'translations/codegen_loader.g.dart';
Future<void> main()async{

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform
  // );
  // GetStorage.init();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      fallbackLocale: Locale("ar"),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return
    //   MultiProvider(providers: [
    //   // Provider<HomeProvider>(create: (_)=>HomeProvider()),
    //   ListenableProvider<AuthProvider>(create: (_) => AuthProvider()),
    //   ListenableProvider<ProfileProvider>(create: (_)=>ProfileProvider()),
    //   ListenableProvider<ProcessProvider>(create: (_)=>ProcessProvider()),
    // //  ListenableProvider<ChatProvider>(create: (_)=>ChatProvider()),
    //   ListenableProvider<CreateEnvironmentProvider>(create: (_)=>CreateEnvironmentProvider()),
    // ],
    //     child:
        Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
              title: "Pinkey",
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
               locale: Locale('ar'),
              debugShowCheckedModeBanner: false,
               // theme: ThemeData.dark(),
             theme: ThemeManager.myTheme,
              // theme: getApplicationTheme(isDark: appProvider.darkTheme),
              home:const SplashView()
              // home:const AddNewCourseView()
          );
        }
    //)
    );
  }
}
//GetX  MVC ==> Model View Controller
//          FocusManager.instance.primaryFocus!.unfocus();
