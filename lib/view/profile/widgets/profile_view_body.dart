import 'dart:io';
import '/view/edit_password/edit_passord_view.dart';

import '/view/resourse/style_manager.dart';
import '../../resourse/string_manager.dart';
import 'package:flutter/material.dart';
import '../../login/login_view.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/values_manager.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../manager/widgets/button_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '/view/resourse/assets_manager.dart';
import '/translations/locale_keys.g.dart';
import '/view/resourse/color_manager.dart';

class ProfileViewBody extends StatefulWidget {
  final bool isIgnor;

  const ProfileViewBody({super.key, required this.isIgnor});

  @override
  State<ProfileViewBody> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileViewBody> {
  final FnameController = TextEditingController(text: 'عبير');
  final LnameController = TextEditingController(text: 'عبد الغني');
  final emailController = TextEditingController(text: 'haya,143@gmail.com');
  final phoneController = TextEditingController(text: '05965626202');
  final passwordController = TextEditingController(text: '123AA@#fg');
  final confirmPassworddController = TextEditingController(text: '123AA@#fg');
  final formKey = GlobalKey<FormState>();

  // final name = TextEditingController(text: "أحمد الحريري");

  bool nameIgnor = true;

  bool emailIgnor = true;

  // ProfileProvider profileProvider = ProfileProvider();
  ImagePicker picker = ImagePicker();

  XFile? image;

  pickFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  pickFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    // await uploadImage( );
    setState(() {});
  }

//   Future uploadImage() async {
//     try {
//       String path = basename(image!.path);
//       print(image!.path);
//       File file =File(image!.path);
//
// //FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
//       Reference storage = FirebaseStorage.instance.ref().child("profileImage/${path}");
//       UploadTask storageUploadTask = storage.putFile(file);
//       TaskSnapshot taskSnapshot = await storageUploadTask;
//       //Const.LOADIG(context);
//       String url = await taskSnapshot.ref.getDownloadURL();
//       //Navigator.of(context).pop();
//       print('url $url');
//       return url;
//     } catch (ex) {
//       //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
//     }
//   }

  @override
  Widget build(BuildContext context) {
    // final profileProvider = Provider.of<ProfileProvider>(context);
    // final loginProvider = Provider.of<LoginProvider>(context);
    // profileProvider.serial_number.text=profileProvider.user.serialNumber;
    return IgnorePointer(
      ignoring: widget.isIgnor,
      child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p10, horizontal: AppPadding.p16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: CircleAvatar(
                        radius: 12.5.w,
                        backgroundColor: ColorManager.borderColor,
                        child: image == null
                            ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                          // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                          "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                          imageBuilder: (context, imageProvider) =>
                              Image(image: imageProvider),
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                        )
                            : ClipOval(
                          child: Image.file(File(image!.path),
                            width: 4.w,
                            height: 4.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: CircleAvatar(
                          radius: 4.w,
                          backgroundColor: ColorManager.borderColor,
                          child: SvgPicture.asset(
                              AssetsManager.edit_imageIMG),
                        )
                    )
                  ],
                ),
                const SizedBox(height: AppSize.s20,),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStringsManager.first_name,
                                  style: getRegularStyle(
                                      color: Theme
                                          .of(context)
                                          .textTheme
                                          .subtitle1!
                                          .color,
                                      fontSize: 12.sp),
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                TextFiledApp(
                                    controller: FnameController,
                                    hintText: AppStringsManager.first_name),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStringsManager.last_name,
                                  style: getRegularStyle(
                                      color: Theme
                                          .of(context)
                                          .textTheme
                                          .subtitle1!
                                          .color,
                                      fontSize: 12.sp),
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                TextFiledApp(
                                    controller: LnameController,
                                    hintText: AppStringsManager.last_name),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Text(
                        AppStringsManager.phone_number,
                        style: getRegularStyle(
                            color: Theme
                                .of(context)
                                .textTheme
                                .subtitle1!
                                .color,
                            fontSize: 12.sp),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      TextFiledApp(
                        controller: phoneController,
                        hintText: AppStringsManager.type + " " +
                            AppStringsManager.phone_number,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Text(
                        AppStringsManager.email,
                        style: getRegularStyle(
                            color: Theme
                                .of(context)
                                .textTheme
                                .subtitle1!
                                .color,
                            fontSize: 12.sp),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      TextFiledApp(
                        controller: emailController,
                        hintText: AppStringsManager.type + " " +
                            AppStringsManager.email,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStringsManager.password,
                            style: getRegularStyle(
                                color: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1!
                                    .color,
                                fontSize: 12.sp),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => EditPassordView(),
                                  transition: Transition.leftToRight);
                            },
                            child: Text(
                              AppStringsManager.edit_password,
                              style: getRegularStyle(
                                  color: ColorManager.thirdlyColor,
                                  fontSize: 8.sp),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      TextFiledApp(
                        controller: passwordController,
                        hintText: AppStringsManager.type + " " +
                            AppStringsManager.password,
                        obscureText: true,
                        suffixIcon: true,
                      ),
                      const SizedBox(height: AppSize.s10,),


                    ],
                  ),
                ),
                ButtonApp(
                    color: ColorManager.thirdlyColor,
                    text: AppStringsManager.save, onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print('yes');
                  }
                }),

              ],
            ),
          )),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: Container(
              height: 20.h,
              width: SizerUtil.width - 30.0,
              color: Theme
                  .of(context)
                  .cardColor,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pickFromCamera();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              AppPadding.p8),
                          child: Row(
                            children: [
                              Icon(Icons.camera),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text("Camera"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pickFromGallery();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              AppPadding.p8),
                          child: Row(
                            children: [
                              Icon(Icons.photo),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text("Gallery"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // removeGallery();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              AppPadding.p8),
                          child: Row(
                            children: [
                              Icon(Icons.delete),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text("Remove"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
/*
Center(
                                          child: Container(
                                            height: Sizer.getW(context) * 0.4,
                                            width:
                                                Sizer.getW(context) - AppSize.s30,
                                            color: Theme.of(context).cardColor,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        pickFromCamera();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.all(
                                                            AppPadding.p8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.camera),
                                                            const SizedBox(
                                                              width: AppSize.s8,
                                                            ),
                                                            Text("Camera"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 0.0,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: ()  {

                                                        pickFromGallery();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.all(
                                                            AppPadding.p8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.photo),
                                                            const SizedBox(
                                                              width: AppSize.s8,
                                                            ),
                                                            Text("Gallery"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 0.0,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: ()  {

                                                        removeGallery();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.all(
                                                            AppPadding.p8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.delete),
                                                            const SizedBox(
                                                              width: AppSize.s8,
                                                            ),
                                                            Text("Remove"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
 */