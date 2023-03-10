import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkey/model/models.dart';
import 'package:pinkey/view/payment_for_course/payment_for_course_view.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../controller/book_course_controller.dart';
import '../../../model/utils/const.dart';
import '../../manager/widgets/button_app.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class BookCourseViewBody extends StatefulWidget {
   BookCourseViewBody({Key? key,required this.bookCourseController}) : super(key: key);
  BookCourseController bookCourseController;
  @override
  State<BookCourseViewBody> createState() => _BookCourseViewBodyState();
}

class _BookCourseViewBodyState extends State<BookCourseViewBody> {
  int _selectedIndex = 0;
  List<DateTime> listDate=[];
  @override
  void initState() {
    // TODO: implement initState
    widget.bookCourseController.getDatesAndHours();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // print(widget.bookCourseController.listDateTime);
    // print(widget.bookCourseController.listTimeOfDay);
   // print(widget.bookCourseController.listDateTime);
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p20),
      children: [
        Text(
          'اختاري تاريخ الحجز',
          style: getRegularStyle(
              color: Theme.of(context).textTheme.subtitle1!.color,
              fontSize: 12.sp),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
          decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s8),
              border: Border.all(color: ColorManager.lightGray.withOpacity(.5)),
              boxShadow: [
                BoxShadow(
                    color: ColorManager.lightGray.withOpacity(.3),
                    blurRadius: AppSize.s4)
              ]),
          child: SfDateRangePicker(
            initialDisplayDate: DateTime.now(),

            onSelectionChanged: (date) {
              // for(DateTime dateTime1 in (List<DateTime>)(date.value)){
              //   bool checkDate=false;
              //   for(DateTime dateTime2 in widget.bookCourseController.listDateTime)
              //     if(widget.bookCourseController.compareDateYMD(dateTime1: dateTime1, dateTime2: dateTime2)==0)
              //       checkDate=true;
              //     if(!checkDate)
              //       date.value.remove(dateTime1);
              //   checkDate=false;
              // }
              listDate=date.value;
              print(listDate);
            },
            selectionMode: DateRangePickerSelectionMode.multiple,
            minDate: widget.bookCourseController.listDateTime.first,
            maxDate: widget.bookCourseController.listDateTime.last,
            initialSelectedRange: PickerDateRange(
                widget.bookCourseController.listDateTime.first,
                widget.bookCourseController.listDateTime.last
                // DateTime.now().subtract(const Duration(days: 4)),
                // DateTime.now().add(const Duration(days: 3))
            ),
          ),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Text(
          'اختاري وقت الحجز',
          style: getRegularStyle(
              color: Theme.of(context).textTheme.subtitle1!.color,
              fontSize: 12.sp),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Text(
          'الأوقات الظاهرة حسب التوقيت المحلي',
          style: getRegularStyle(
              color: Theme.of(context).textTheme.subtitle1!.color,
              fontSize: 12.sp),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Wrap(
          children: [
            for (int i = 0; i < widget.bookCourseController.listTimeOfDay.length; i++)
              GestureDetector(
                onTap: () {
                  _selectedIndex = i;
                  setState(() {
                    print(widget.bookCourseController.listTimeOfDay[_selectedIndex]);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                  child: Chip(
                    backgroundColor: _selectedIndex == i?ColorManager.primaryColor.withOpacity(.2):ColorManager.lightGray.withOpacity(.5),
                    onDeleted: (){
                    },
                    deleteIcon: Icon(Icons.access_time_filled_sharp,color: _selectedIndex == i?ColorManager.primaryColor:ColorManager.black,),
                    label: Text('${DateFormat().add_Hm().format(
                      DateTime(2000,1,1,widget.bookCourseController.listTimeOfDay[i].hour,widget.bookCourseController.listTimeOfDay[i].minute),
                    )} - ${DateFormat().add_Hm().format(
                      DateTime(2000,1,1,widget.bookCourseController.listTimeOfDay[i].hour+1,widget.bookCourseController.listTimeOfDay[i].minute),
                    )}',style: getRegularStyle(
                        color: _selectedIndex == i?ColorManager.primaryColor:ColorManager.black,
                        fontSize: 8.sp

                    ),),
                  ),
                ),
              )
          ],
        ),
        ButtonApp(
          text: "استمرار",
          onPressed: (){
            if(listDate.length>0){
              widget.bookCourseController.bookCourseProvider.bookCourse=BookCourse(idCourse:'' , idTrainer: '', idUser: '',
                  typeCar: '', dateTime: DateTime.now(), price: 0, listDateTime: listDate
                  ,from: widget.bookCourseController.listTimeOfDay[_selectedIndex],to: widget.bookCourseController.listTimeOfDay[_selectedIndex]);
              Get.to(()=>PaymentForCourseView(),transition: Transition.circularReveal);
            }else{
              Const.TOAST(context,textToast:AppStringsManager.should_select_date );
            }

          },
        ),
      ],
    );
  }

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  //
  // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   setState(() {
  //     if (args.value is PickerDateRange) {
  //       _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
  //           // ignore: lines_longer_than_80_chars
  //           ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
  //     } else if (args.value is DateTime) {
  //       _selectedDate = args.value.toString();
  //     } else if (args.value is List<DateTime>) {
  //       _dateCount = args.value.length.toString();
  //     } else {
  //       _rangeCount = args.value.length.toString();
  //     }
  //   });
  // }
}
