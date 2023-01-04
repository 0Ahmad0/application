import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/button_app.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class BookCourseViewBody extends StatefulWidget {
  const BookCourseViewBody({Key? key}) : super(key: key);

  @override
  State<BookCourseViewBody> createState() => _BookCourseViewBodyState();
}

class _BookCourseViewBodyState extends State<BookCourseViewBody> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppPadding.p20),
            children: [
              const SizedBox(
                height: AppSize.s20,
              ),
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
                    print(date.value);
                  },
                  selectionMode: DateRangePickerSelectionMode.multiple,
                  initialSelectedRange: PickerDateRange(
                      DateTime.now().subtract(const Duration(days: 4)),
                      DateTime.now().add(const Duration(days: 3))),
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
                  for (int i = 0; i < 5; i++)
                    GestureDetector(
                      onTap: () {
                        _selectedIndex = i;
                        setState(() {
                          print(_selectedIndex);
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
                                DateTime.now(),
                              )} - ${DateFormat().add_Hm().format(
                                DateTime.now(),
                              )}',style: getLightStyle(
                            color: _selectedIndex == i?ColorManager.primaryColor:ColorManager.black,
                            fontSize: 8.sp

                          ),),
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: ButtonApp(
            text: "استمرار",
            onPressed: (){
              Get.dialog(
                Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      height: (SizerUtil.height / 2) - 16,
                      margin: const EdgeInsets.all(AppMargin.m16),
                      padding: const EdgeInsets.all(AppPadding.p20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        color: ColorManager.white
                      ),
                      child: Column(
                        children: [
                          Expanded(flex:2,child: FlutterLogo(
                            size: 150.0,
                          )),
                          Text('تم ارسال طلبكم برقم #1145',style: getRegularStyle(
                              color: Theme.of(context).textTheme.subtitle1!.color,
                              fontSize: 14.sp
                          )),
                          const SizedBox(height: AppSize.s10,),
                          Text('سيتم الرد على طلبكم بالقبول او الرفض في اقرب وقت يرجى متابعة حالة الطلب في صفحة المواعيد',style: getRegularStyle(
                            color: Theme.of(context).textTheme.subtitle1!.color,
                            fontSize: 12.sp
                          ).copyWith(height: 1.5),),
                          const SizedBox(height: AppSize.s10,),
                          TextButton(
                            onPressed: (){
                              Get.back();
                            },
                            child: Text('موافق',style: getRegularStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12.sp
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              );
            },
          ),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
      ],
    );
  }

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }
}
