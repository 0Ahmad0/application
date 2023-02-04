// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "app_name": "بنكي",
  "app_description": "للتديب على قيادة السيارات",
  "welcome_back": "أهلا بعودتك",
  "login_to_complete_book": "قومي بتسجيل الدخول حتى تستطيعي إجراء حجوزاتك",
  "login_now": "سجلي دخولك الان",
  "phone_number": "رقم الهاتف",
  "login_by_email": "سجلي باستخدام البريد الالكتروني",
  "password": "كلمة المرور",
  "type": "إدخال",
  "forget_password": "نسيتي كلمة المرور؟",
  "login": "تسجبل دخول",
  "do_not_have_account": "لا أملك حساب في التطبيق؟ ",
  "sign_up": "إنشاء حساب",
  "loading": "جاري التحميل ...",
  "active": "نشط",
  "non_active": "غير نشط",
  "toast": "",
  "toast_successfully_created": "تم إنشاء الحساب بنجاح",
  "toast_successfully_update": "تم تحديث المعلومات بنجاح",
  "toast_Unsuccessfully_created": "فشل إنشاء الحساب",
  "toast_email_already_use": "البريد الإلكتروني قيد الاستخدام بالفعل",
  "toast_short_password": "كلمة المرور قصيرة\nيجب ألا تقل عن 6 أحرف",
  "toast_successfully_logged": "تم تسجيل الدخول بنجاح",
  "toast_email_invalid": "البريد غير صحيح",
  "toast_password_invalid": "كلمة السر غير صحيحة",
  "toast_network_error": "حدث خطأ في الاتصال",
  "toast_account_invalid": "الحساب غير صحيح",
  "toast_Bad_data_fetch": "خطأ داخلي: جلب سيء للبيانات",
  "toast_time_out": "خطأ في الاتصال",
  "toast_given_empty": "القيمة المعطاء فارغة",
  "toast_account_not_active": "الحساب غير نشط"
};
static const Map<String,dynamic> en = {
  "app_name": "PinKey",
  "app_description": "To train driving cars",
  "welcome_back": "Welcome back",
  "login_to_complete_book": "Log in to make your bookings",
  "login_now": "Sign in now",
  "phone_number": "Phone number",
  "login_by_email": "Register using email",
  "password": "Password",
  "type": "Enter",
  "forget_password": "Forgot your password? ",
  "login": "Login",
  "do_not_have_account": "Don't have an account ? ",
  "sign_up": "Sign up",
  "loading": "Loading ...",
  "active": "Active",
  "non_active": "Non Active",
  "toast": "",
  "toast_successfully_created": "Account successfully created",
  "toast_successfully_update": "Account successfully update",
  "toast_Unsuccessfully_created": "Account Unsuccessfully created",
  "toast_email_already_use": "The email address is already in use",
  "toast_short_password": "short password\nshould be at least 6 characters",
  "toast_successfully_logged": "successfully logged",
  "toast_email_invalid": "The email is invalid",
  "toast_password_invalid": "The password is invalid",
  "toast_network_error": "A network error",
  "toast_account_invalid": "Account is invalid",
  "toast_Bad_data_fetch": "Internal Error: Bad data fetch",
  "toast_time_out": "time out",
  "toast_given_empty": "Given String is empty or null",
  "toast_account_not_active": "Account not Active"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
