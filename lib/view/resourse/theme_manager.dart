import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '/view/resourse/color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(255, 0, 100, .1),
  100: Color.fromRGBO(255, 0, 100, .2),
  200: Color.fromRGBO(255, 0, 100, .3),
  300: Color.fromRGBO(255, 0, 100, .4),
  400: Color.fromRGBO(255, 0, 100, .5),
  500: Color.fromRGBO(255, 0, 100, .6),
  600: Color.fromRGBO(255, 0, 100, .7),
  700: Color.fromRGBO(255, 0, 100, .8),
  800: Color.fromRGBO(255, 0, 100, .9),
  900: Color.fromRGBO(255, 0, 100, 1),
};

class ThemeManager {
  static var myTheme = ThemeData(
    textTheme: TextTheme(
        subtitle2:getRegularStyle(color: ColorManager.lightGray)
    ),
    fontFamily:FontManager.fontFamilyAR,
    dividerColor: ColorManager.white,
    tabBarTheme: TabBarTheme(
      labelStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: AppSize.s14
      ),
        unselectedLabelStyle: getRegularStyle(
            color: ColorManager.black,
            fontSize: AppSize.s14
        )
    ),
    radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith(
            (states) => ColorManager.primaryColor)),
    primarySwatch: MaterialColor(ColorManager.primaryColor.value, color),
    primaryColor: ColorManager.primaryColor,
    iconTheme: IconThemeData(
      color: ColorManager.primaryColor,
    ),
    primaryColorLight: ColorManager.primaryColor,
    primaryIconTheme: IconThemeData(color: ColorManager.primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xfff5f5f5),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e3e3))),
      iconColor: ColorManager.primaryColor,
      hintStyle: getRegularStyle(
          color: ColorManager.lightGray, fontSize: FontSize.s20),
      //label
      labelStyle:
          getMediumStyle(color: ColorManager.black, fontSize: FontSize.s14),
      //error
      errorStyle:
          getRegularStyle(color: ColorManager.error, fontSize: FontSize.s14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s24),
          minimumSize: Size(double.infinity, AppSize.s60),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s8))),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.primaryColor),
    appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.primaryColor,
        centerTitle: true,
        elevation: AppSize.s4,
        titleTextStyle:
            getRegularStyle(
                color: ColorManager.black, fontSize: 14.sp
            )),
    scaffoldBackgroundColor: ColorManager.white
  );
}
