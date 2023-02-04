import 'package:pinkey/view/trainer/add_new_course/add_new_course_view.dart';
import 'package:pinkey/view/trainer/complete_information/complete_information_view.dart';

import '/view/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/view/resourse/theme_manager.dart';
import 'package:sizer/sizer.dart';

Future<void> main()async{

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform
  // );

  runApp(
   MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
              title: "Pinkey",
               locale: Locale('ar'),
              debugShowCheckedModeBanner: false,
               // theme: ThemeData.dark(),
             theme: ThemeManager.myTheme,
              // theme: getApplicationTheme(isDark: appProvider.darkTheme),
              home:const SplashView()
              // home:const AddNewCourseView()
          );
        }
    );
  }
}
//GetX  MVC ==> Model View Controller
//          FocusManager.instance.primaryFocus!.unfocus();
