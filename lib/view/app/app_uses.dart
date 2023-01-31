import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class AppUsuallyUsed{
  static TimeOfDay _selectedTime = TimeOfDay.now();
  static DateTime _selectedDate = DateTime.now();
  static selectDate(BuildContext context,TextEditingController textEditingController) async {
    var newSelectedDate = await showDatePicker(
      builder: (context, child) {
        return child!;
      },
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      textEditingController
        ..text = DateFormat.yMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
  static selectTime(BuildContext context,TextEditingController textEditingController) async {

    _selectedTime = TimeOfDay.now();

    Navigator.of(context).push(
      showPicker(
        context: context,
        value: _selectedTime,
        onChange: (time){
          _selectedTime = time;
          textEditingController.text=  _selectedTime.format(context);
        },
        minuteInterval: MinuteInterval.FIVE,
        is24HrFormat: false,
      ),
    );
  }
}