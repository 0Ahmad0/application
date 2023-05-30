import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinkey/controller/book_course_controller.dart';
import 'package:pinkey/controller/provider/book_course_provider.dart';
import 'package:pinkey/controller/provider/chat_provider.dart';
import 'package:pinkey/controller/provider/profile_provider.dart';
import 'package:pinkey/model/utils/consts_manager.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/notification_provider.dart';
import '../../../model/models.dart';
import '../../../model/models.dart' as model;
import '../../../model/utils/const.dart';
import '/view/chat/widgets/chat_room.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/container_icons.dart';
import '../../resourse/assets_manager.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/string_manager.dart';
import '../../resourse/style_manager.dart';

class AppointmentsViewBody extends StatelessWidget {
  AppointmentsViewBody({Key? key, required this.bookCourseController})
      : super(key: key);
  BookCourseController bookCourseController;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
        Text(
          AppStringsManager.appointments,
          style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        //TODO :
        FutureBuilder(
            //prints the messages to the screen0
            future: bookCourseController.fetchBookCourses(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return (bookCourseController.bookCourseProvider.bookCourses
                            .listBookCourse.length >
                        0)
                    ? buildCourses(context,
                        value: bookCourseController.bookCourseProvider)
                    : Const.SHOWLOADINGINDECATOR();
              } else {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return ChangeNotifierProvider<BookCourseProvider>.value(
                      value: Provider.of<BookCourseProvider>(context),
                      child: Consumer<BookCourseProvider>(
                          builder: (context, value, child) {
                        return buildCourses(context, value: value);
                      }));

                  /// }));
                } else {
                  return const Text('Empty data');
                }
              }
            }),
      ],
    );
  }

  Widget buildCourses(BuildContext context,
      {required BookCourseProvider value}) {
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return ListBody(children: [
      for (int i = 0; i < value.bookCourses.listBookCourse.length; i++)
        buildCoursesDetails(context,
            bookCourse: value.bookCourses.listBookCourse[i],
            onProgress: (value.bookCourses.listBookCourse[i].state ==
                        AppStringsManager.ongoing &&
                    (bookCourseController.compareDateYMD(
                                dateTime1: value.bookCourses.listBookCourse[i]
                                    .listDateTime.first,
                                dateTime2: DateTime.now()) >
                            0 ||
                        (AppConstants.collectionTrainer
                            .contains(profileProvider.user.typeUser))))
                ? true
                : false,
            color: value.bookCourses.listBookCourse[i].state ==
                    AppStringsManager.ongoing
                ? Colors.amber
                : value.bookCourses.listBookCourse[i].state ==
                        AppStringsManager.completed
                    ? Colors.green
                    : Colors.red,
            statusText: value.bookCourses.listBookCourse[i].state ==
                    AppStringsManager.ongoing
                ? AppStringsManager.ongoing
                : value.bookCourses.listBookCourse[i].state ==
                        AppStringsManager.completed
                    ? AppStringsManager.completed
                    : AppStringsManager.cancelled)
    ]);
  }

  Widget buildCoursesDetails(BuildContext context,
      {onProgress = false,
      required color,
      required statusText,
      required BookCourse bookCourse}) {
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    if (bookCourseController.courseProvider.mapCourses[bookCourse.idCourse] ==
        null)
      bookCourseController.courseProvider.mapCourses[bookCourse.idCourse] =
          Course.init();
    print(bookCourseController.courseProvider.mapCourses[bookCourse.idCourse]);
    return Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.sp),
        border: Border.all(color: ColorManager.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AssetsManager.trainer_course_nameIMG),
                  const SizedBox(
                    width: AppSize.s4,
                  ),
                  Text(
                    bookCourseController
                        .courseProvider.mapCourses[bookCourse.idCourse]!.name,
                    overflow: TextOverflow.ellipsis,
                    // AppStringsManager.trainer_courses_name
                  ),
                  const SizedBox(
                    width: AppSize.s4,
                  ),
                  Text(
                    bookCourseController.courseProvider
                        .mapCourses[bookCourse.idCourse]!.category,
                    //'(للمبتدئين)',
                    style: getRegularStyle(color: ColorManager.lightGray),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                width: 20.w,
                padding: const EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(50.sp)),
                child: Text(
                  statusText,
                  style: getRegularStyle(
                      color: ColorManager.white, fontSize: 10.sp),
                ),
              )
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            subtitle: Padding(
              padding: const EdgeInsets.only(right: AppPadding.p30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text(
                    '${bookCourseController.courseProvider.mapCourses[bookCourse.idCourse]!.name}',
                    // 'هذه المكان مخصص لوضع عنوان مناسب للدورة المقدمة'
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(
                    children: [
                      Text(
                        AppStringsManager.show_trainer_course_details,
                        style: getRegularStyle(
                            color: ColorManager.primaryColor, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildContainerDetailsTrainer(
                  text: '${DateFormat.yMd().format(bookCourse.dateTime)}',
                  icon: SvgPicture.asset(
                    AssetsManager.appointmentsIMG,
                    color: ColorManager.secondaryColor,
                    width: 16.sp,
                    height: 16.sp,
                  )),
              buildContainerDetailsTrainer(
                  text:
                      '${DateFormat().add_Hm().format(DateTime(2000, 1, 1, bookCourse.from!.hour, bookCourse.from!.minute)) + ' - ' + DateFormat().add_Hm().format(DateTime(2000, 1, 1, bookCourse.from!.hour + 1, bookCourse.from!.minute))}',
                  icon: Icon(
                    Icons.access_time_filled,
                    size: 16.sp,
                    color: ColorManager.secondaryColor,
                  )),
              buildContainerDetailsTrainer(
                  text: '${bookCourse.price} ر.س',
                  icon: Icon(
                    Icons.monetization_on,
                    size: 16.sp,
                    color: ColorManager.secondaryColor,
                  )),
            ],
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Visibility(
            visible: onProgress,
            child: Row(
              children: [
                if (bookCourse.checkState)
                  Expanded(
                    child: ButtonApp(
                      radius: 100.sp,
                      height: AppSize.s50,
                      fontSize: 10.sp,
                      text: AppStringsManager.start_conversation,
                      onPressed: () async {
                        chatProvider.chat.listIdUser = [
                          bookCourse.idUser,
                          bookCourse.idTrainer
                        ];
                        Const.LOADIG(context);
                        await chatProvider.fetchChatByListIdUser(
                            listIdUser: chatProvider.chat.listIdUser);
                        Get.back();
                        Get.to(
                            () => ChatRoom(
                                  recId: (profileProvider.user.id ==
                                          bookCourse.idUser
                                      ? bookCourse.idTrainer
                                      : bookCourse.idUser),
                                ),
                            transition: Transition.downToUp);
                      },
                    ),
                  ),
                if (!bookCourse.checkState &&
                    (AppConstants.collectionTrainer
                        .contains(profileProvider.user.typeUser)))
                  Expanded(
                    child: ButtonApp(
                      radius: 100.sp,
                      height: AppSize.s50,
                      fontSize: 10.sp,
                      text: AppStringsManager.acception_request,
                      onPressed: () async {
                        await bookCourseController.acceptBookCourse(context,
                            bookCourse: bookCourse);
                        if (profileProvider.user.typeUser
                            .contains(AppConstants.collectionTrainer))
                          await NotificationProvider().addNotification(context,
                              notification: model.Notification(
                                  idUser: bookCourse.idUser,
                                  idNotification: bookCourse.id,
                                  title: AppStringsManager.accept_book_course,
                                  dateTime: DateTime.now(),
                                  subtitle: AppStringsManager
                                      .accept_trainer_book_course,
                                  message: ''));
                      },
                    ),
                  ),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Expanded(
                  child: ButtonApp(
                    borderColor: ColorManager.primaryColor,
                    color: ColorManager.white,
                    textColor: ColorManager.primaryColor,
                    radius: 100.sp,
                    fontSize: 10.sp,
                    height: AppSize.s50,
                    text: AppStringsManager.cancellation_booking,
                    onPressed: () async {
                      final result = await bookCourseController
                          .cancelBookCourse(context, bookCourse: bookCourse);
                      if (result['status']) if (profileProvider.user.typeUser
                          .contains(AppConstants.collectionTrainer))
                        await NotificationProvider().addNotification(context,
                            notification: model.Notification(
                                idUser: bookCourse.idUser,
                                idNotification: bookCourse.id,
                                title: AppStringsManager.cancel_book_course,
                                dateTime: DateTime.now(),
                                subtitle: AppStringsManager
                                    .cancel_trainer_book_course,
                                message: ''));
                      else
                        await NotificationProvider().addNotification(context,
                            notification: model.Notification(
                                idUser: bookCourse.idTrainer,
                                idNotification: bookCourse.id,
                                title: AppStringsManager.cancel_book_course,
                                dateTime: DateTime.now(),
                                subtitle:
                                    AppStringsManager.cancel_user_book_course,
                                message: ''));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
