import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';
import '/translations/locale_keys.g.dart';
import '/view/resourse/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import '../../../model/utils/app_sizer.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';
import 'dart:ui' as ui;

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.black,
        ),
          elevation: 0.0,
          backgroundColor: ColorManager.white,
          title: Text('عبير عبد الغني')),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 80,
              left: AppPadding.p12,
              right: AppPadding.p12,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return MessageFile(
                index: index,
              );
            },
          ),
          Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(color: ColorManager.white, boxShadow: [
              BoxShadow(
                  color: ColorManager.black.withOpacity(.3),
                  blurRadius: AppSize.s4)
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: TextField(
                  style: getRegularStyle(
                      color: Theme.of(context).cardColor, fontSize: 14.sp),
                  decoration: InputDecoration(
                      border: BorderType,
                      enabledBorder: BorderType,
                      focusedBorder: BorderType,
                      hintText: 'اكتب رسالتك هنا...',
                      suffixIcon: IconButton(
                        onPressed: () async {
                          var file = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );
                          if (file != null) {
                            print('yes');
                          }
                        },
                        icon: Icon(Icons.image),
                      )),
                )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                      radius: 20.sp,
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).cardColor,
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

var BorderType = OutlineInputBorder(
    borderRadius: BorderRadius.circular(11.sp),
    borderSide: BorderSide(color: Colors.transparent));

class MessageFile extends StatelessWidget {
  const MessageFile({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "AppStrings.areYouSure",
          desc: "AppStrings.deleteThisMessage",
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              index.isOdd ? CircleAvatar() : const SizedBox(),
              index.isOdd
                  ? const SizedBox(
                      width: AppSize.s8,
                    )
                  : const SizedBox(),
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  margin: EdgeInsets.only(
                    top: AppMargin.m10,
                    bottom: AppMargin.m4,
                    left: index.isEven ? 0 : AppSizer.getW(context) / 5,
                    right: index.isOdd ? 0 : AppSizer.getW(context) / 5,
                  ),
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? ColorManager.thirdlyColor
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s6),
                      bottomLeft: Radius.circular(AppSize.s6),
                      bottomRight: Radius.circular(AppSize.s6),
                    ),
                  ),
                  child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(AppPadding.p4),
                        child: Text(
                    "Message Message Message Message Message Message Message Message Message Message Message Message ",
                    style: getRegularStyle(
                          color: index.isEven
                              ? ColorManager.black
                              : ColorManager.white),
                  ),
                      )),
                ),
              ),
            ],
          ),
          Container(
            padding:  index.isOdd?EdgeInsets.symmetric(horizontal:AppSizer.getW(context)/8 ):EdgeInsets.zero,
            margin: EdgeInsets.only(
              left: index.isEven ? 0 : AppSizer.getW(context) / 5,
              right: index.isOdd ? 0 : AppSizer.getW(context) / 5,
            ),
            child: Text(
              '${DateFormat('', 'ar').add_EEEE().add_jm().format(DateTime.now())}',
              textAlign: index.isOdd ? TextAlign.start : TextAlign.end,
              style: getLightStyle(color: Color(0xffAFAFAF), fontSize: 10.sp),
            ),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
        ],
      ),
    );
  }
}
