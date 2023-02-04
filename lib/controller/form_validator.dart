import '../view/resourse/string_manager.dart';
import '/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class FormValidator {
  static RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  ///@Email Validator
  static String? emailValidator(String? value) {
    if (!value!.isEmail) {
      return tr(LocaleKeys.enter_valid_email);
    }
    if (value.trim().isEmpty) {
      return tr(LocaleKeys.field_required);
    }
    return null;
  }

  ///@Phone Validator
  static String? phoneValidator(String? value) {
    if (!value!.isPhoneNumber) {
      return tr(LocaleKeys.enter_valid_phone_number);
    }
    if (value.trim().isEmpty) {
      return tr(LocaleKeys.field_required);
    }
    return null;
  }

  ///@Password Validator
  static String? passwordValidator(String? value) {
    if ((!validatePassword(value!)) || (value.length < 8)) {
      return tr(LocaleKeys.enter_strong_password);
    }
    if (value.trim().isEmpty) {
      return tr(LocaleKeys.field_required);
    }
    return null;
  }

  ///@Password Validator
  static String? confirmPasswordValidator(String? password, String? confirmPassword) {
    if (password!.compareTo(confirmPassword!) != 0) {
      return tr(LocaleKeys.enter_matched_password);
    }
    if (confirmPassword.trim().isEmpty) {
      return tr(LocaleKeys.field_required);
    }
    return null;
  }

  ///@cvvCard Validator
  static String? cvvCardValidator(String? val){
    if(val!.trim().isEmpty)
      return AppStringsManager.filed_Required;
    if(val.length != 3)
      return AppStringsManager.cvv_3letter;

    return null;
  }

  ///@cvvCard Validator
  static String? cardNumberValidator(String? val){
    if(val!.trim().isEmpty)
      return AppStringsManager.filed_Required;
    if(val.length != 16)
      return AppStringsManager.card_number_16letter;

    return null;
  }

  ///@Helper Function
  static bool validatePassword(String value) {
    return regex.hasMatch(value);
  }
}
