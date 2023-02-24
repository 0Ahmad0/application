import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinkey/model/utils/consts_manager.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/chat_provider.dart';
import '../../../controller/provider/process_provider.dart';
import '../../../controller/provider/profile_provider.dart';
import '../../../model/models.dart';
import '../../../model/utils/const.dart';
import '../../app/picture/cach_picture_widget.dart';
import '/view/manager/const.dart';
import '/view/resourse/string_manager.dart';
import '/view/resourse/string_manager.dart';
import 'package:readmore/readmore.dart';
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

class ChatRoom extends StatefulWidget {
  ChatRoom({super.key, required this.recId});
  final String recId;
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final messageController = TextEditingController();
  var getChat;
  late ProfileProvider profileProvider;
  late ChatProvider chatProvider;
  late ProcessProvider processProvider;
  final textController=TextEditingController();
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    chatProvider = Provider.of<ChatProvider>(context, listen: false);

    chatProvider.fetchChatByListIdUser( listIdUser: chatProvider.chat.listIdUser);
    getChatFun();
    super.initState();
  }

  getChatFun() async {
    // chatProvider.fetchChatByListIdUser( listIdUser: chatProvider.chat.listIdUser);
    getChat = chatProvider.fetchChatStream( idChat: chatProvider.chat.id);
    return getChat;
  }
  @override
  Widget build(BuildContext context) {
    chatProvider = Provider.of<ChatProvider>(context);
    processProvider = Provider.of<ProcessProvider>(context);


    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: ColorManager.black,
          ),
          elevation: 0.0,
          backgroundColor: ColorManager.white,
          title: FutureBuilder(
            //prints the messages to the screen0
              future: chatProvider.fetchUserById(id: widget.recId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return
                    const Text(AppStringsManager.loading);

                }
                else  {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {


                    return
                      ListTile(
                        title: Text(
                            chatProvider.user.name
                          // processProvider.fetchLocalNameUser(idUser:widget.recId),
                        ),
                        leading: ClipOval(
                          child:
                          CacheNetworkImage(
                            photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                            '${chatProvider.user.photoUrl}',
                            width: 10.w,
                            height: 10.w,
                            boxFit: BoxFit.fill,
                            waitWidget:  Image.asset(
                              AssetsManager.trainerIMG,
                            ),
                            errorWidget:  Image.asset(
                                AssetsManager.trainerIMG
                              //'assets/images/profile.png',
                            ),
                          )
                        ),

                        subtitle: Text('رخصة عمل حر', style: getRegularStyle(
                            color: ColorManager.hintColor,
                            fontSize: 10.sp
                        ),),
                      );
                    /// }));
                  } else {
                    return const Text('Empty data');
                  }
                }

              })
      )
      ,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          StreamBuilder<QuerySnapshot>(
            //prints the messages to the screen0
              stream: getChat,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return
                    Const.SHOWLOADINGINDECATOR();

                }
                else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    Const.SHOWLOADINGINDECATOR();
                    chatProvider.chat.messages.clear();
                  //  print("dd ${chatProvider.chatSend.messages.length}");
                    if(snapshot.data!.docs!.length>1){
                      chatProvider.chat.messages=Messages.fromJson(snapshot.data!.docs!).listMessage;
                      chatProvider.chat.messages.addAll(chatProvider.chatSend.messages);
                    }

                    return
                      ListView.builder(
                        padding: const EdgeInsets.only(
                          bottom: 80,
                          left: AppPadding.p12,
                          right: AppPadding.p12,
                        ),
                        itemCount: chatProvider.chat.messages.length,
                        itemBuilder: (context, index) {
                          return MessageFile(
                            message: chatProvider.chat.messages[index],
                            chatProvider: chatProvider,
                            index: index,
                          );
                        },
                      );
                    //   ListView.builder(
                    //   padding: const EdgeInsets.only(
                    //     bottom: AppPadding.p60,
                    //     left: AppPadding.p12,
                    //     right: AppPadding.p12,
                    //   ),
                    //   itemCount: chatProvider.chat.messages.length,
                    //   itemBuilder: (context, index) {
                    //     return MessageFile(
                    //       chatProvider: chatProvider,
                    //       index: index,
                    //     );
                    //   },
                    // );
                    /// }));
                  } else {
                    return const Text('Empty data');
                  }
                }
                else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }),
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
                    child: TextFormField(
                      controller: messageController,
                      style: getRegularStyle(
                          color: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .color, fontSize: 14.sp),
                      decoration: InputDecoration(
                          border: BorderType,
                          enabledBorder: BorderType,
                          focusedBorder: BorderType,
                          hintText: 'اكتب رسالتك هنا...',
                          hintStyle: getRegularStyle(
                              color: ColorManager.hintColor, fontSize: 12.sp),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                var file = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (file != null) {
                                  print(file.path);
                                  await chatProvider.sendMessage(context, idChat: chatProvider.chat.id,
                                      message: Message(textMessage: '', typeMessage: TypeMessage.image.name,
                                          senderId: profileProvider.user.id, receiveId: widget.recId, sendingTime: DateTime.now(),localUrl: file.path));
                                }
                              },
                              icon: SvgPicture.asset(
                                  AssetsManager.chat_pictureIMG)
                          )),
                    )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                GestureDetector(
                  onTap: () async {

                     chatProvider.sendMessage(context, idChat: chatProvider.chat.id,
                        message: Message(textMessage: messageController.text, typeMessage: TypeMessage.text.name,
                            senderId: profileProvider.user.id, receiveId: widget.recId, sendingTime: DateTime.now()));
                    messageController.clear();
                  },
                  child: CircleAvatar(
                      radius: 20.sp,
                      backgroundColor: ColorManager.primaryColor,
                      child: SvgPicture.asset(AssetsManager.sendIconIMG)),
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
   MessageFile({super.key, required this.index, required this.chatProvider, required this.message});
  final ChatProvider chatProvider;
  late ProfileProvider profileProvider;
  final Message message;
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
          btnOkOnPress: () async {
            await chatProvider.deleteMessage(context, idChat: chatProvider.chat.id, message: message);
          },
        )
          ..show();
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
                        : Theme
                        .of(context)
                        .primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s6),
                      bottomLeft: Radius.circular(AppSize.s6),
                      bottomRight: Radius.circular(AppSize.s6),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p4),
                     child : childMessage(context,message)),
                ),
              ),
            ],
          ),
          Container(
            padding: index.isOdd ? EdgeInsets.symmetric(
                horizontal: AppSizer.getW(context) / 8) : EdgeInsets.zero,
            margin: EdgeInsets.only(
              left: index.isEven ? 0 : AppSizer.getW(context) / 5,
              right: index.isOdd ? 0 : AppSizer.getW(context) / 5,
            ),
            child: Text(
              '${DateFormat('', 'ar').add_EEEE().add_jm().format(
                  message.sendingTime)}',
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
  childMessage(BuildContext context,Message message)   {
    File file= File(message.localUrl);
    if( file.existsSync())
      return childMessageOnline(context,message);
    else
      return childMessageLocal(context,message);
  }
  childMessageOnline(BuildContext context,Message message)  {
   switch(message.typeMessage){
     case 'text':
       return ListTile(
           title: ReadMoreText(
             message.textMessage,
             //'${message.typeMessage} ${index}',
             //"Message Message Message Message Message Message Message Message Message Message Message MessageMessage Message Message Message Message Message Message Message ",
             trimLines: ConstApp.readMoreTextHeight,
             colorClickableText: Colors.pink,
             trimMode: TrimMode.Line,
             trimCollapsedText: AppStringsManager.show_more,
             trimExpandedText: AppStringsManager.show_less,
             moreStyle: getRegularStyle(color: index.isOdd
                 ? ColorManager.black
                 : ColorManager.white,
                 fontSize: 10.sp),
             lessStyle: getRegularStyle(color: index.isOdd
                 ? ColorManager.black
                 : ColorManager.white,
                 fontSize: 10.sp),
             style: getRegularStyle(
                 color: index.isEven
                     ? ColorManager.black
                     : ColorManager.white),
           ));
     case 'image':
       return Container(
         width: 60.w,
         height: 50.w,
         child: Padding(
         padding: const EdgeInsets.all(AppPadding.p4),
           ///TODO add statck
           /// خلفية + ضبابية + دويرة صغيرة بتحتوي ايقونة تحميل وتحتا نص
           child: Stack(
             alignment: Alignment.center,
             children: [

               CacheNetworkImage(
                 photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                 '${message.url}',
                 width: 60.w,
                 height: 50.w,
                 boxFit: BoxFit.cover,
                 waitWidget:  Const.SHOWLOADINGINDECATOR(),
                 errorWidget:  Icon(Icons.error),
               )
             ],
           ),
         ),
       );
   }
  }
   childMessageLocal(BuildContext context,Message message)  {
     switch(message.typeMessage){
       case 'text':
         return ListTile(
             title: Padding(
               padding: const EdgeInsets.all(AppPadding.p4),
               child: ReadMoreText(
                 '${message.typeMessage} ${index}',
                 //"Message Message Message Message Message Message Message Message Message Message Message MessageMessage Message Message Message Message Message Message Message ",
                 trimLines: ConstApp.readMoreTextHeight,
                 colorClickableText: Colors.pink,
                 trimMode: TrimMode.Line,
                 trimCollapsedText: AppStringsManager.show_more,
                 trimExpandedText: AppStringsManager.show_less,
                 moreStyle: getRegularStyle(color: index.isOdd
                     ? ColorManager.black
                     : ColorManager.white,
                     fontSize: 10.sp),
                 lessStyle: getRegularStyle(color: index.isOdd
                     ? ColorManager.black
                     : ColorManager.white,
                     fontSize: 10.sp),
                 style: getRegularStyle(
                     color: index.isEven
                         ? ColorManager.black
                         : ColorManager.white),
               ),
             ));
       case 'image':
         return Container(
           width: 60.w,
           height: 50.w,
           child: Padding(
             padding: const EdgeInsets.all(AppPadding.p4),
             child: Image.asset(message.url),
           ),
         );;
     }
   }

}
