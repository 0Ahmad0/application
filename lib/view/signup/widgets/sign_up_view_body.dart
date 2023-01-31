import '/view/resourse/style_manager.dart';
import '../../resourse/string_manager.dart';
import 'package:flutter/material.dart';
import '../../login/login_view.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/values_manager.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../manager/widgets/button_app.dart';

class SignupViewBody extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassworddController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
      padding: const EdgeInsets.all(AppPadding.p20),
      children: [

                Text(
                  AppStringsManager.sign_up ,
                  style: getRegularStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color,
                      fontSize: 20.sp),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Text(
                  AppStringsManager.fill_data_account,
                  style: getRegularStyle(
                      color: Theme.of(context).textTheme.subtitle2!.color,
                      fontSize: 12.sp),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
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
                                color: Theme.of(context).textTheme.subtitle1!.color,
                                fontSize: 12.sp),
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          TextFiledApp(
                              iconData: Icons.phone_android, hintText: AppStringsManager.first_name),
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
                                color: Theme.of(context).textTheme.subtitle1!.color,
                                fontSize: 12.sp),
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          TextFiledApp(
                              iconData: Icons.phone_android, hintText: AppStringsManager.last_name),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Text(
                  AppStringsManager.phone_number,
                  style: getRegularStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color,
                      fontSize: 12.sp),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFiledApp(
                  iconData: Icons.phone_android,
                  hintText: AppStringsManager.type + " " + AppStringsManager.phone_number,
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Text(
                  AppStringsManager.email,
                  style: getRegularStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color,
                      fontSize: 12.sp),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFiledApp(
                  iconData: Icons.email,
                  hintText: AppStringsManager.type + " " + AppStringsManager.email,
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Text(
                  AppStringsManager.password,
                  style: getRegularStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color,
                      fontSize: 12.sp),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFiledApp(
                  iconData: Icons.lock,
                  hintText: AppStringsManager.type + " " + AppStringsManager.password,
                  obscureText: true,
                  suffixIcon: true,
                ),

                const SizedBox(
                  height: AppSize.s20,
                ),
                ButtonApp(text: AppStringsManager.sign_up, onPressed: (){
                  if(formKey.currentState!.validate()){
                    Get.snackbar("title", "message");
                    Get.to(()=>LoginView());
                  }
                }),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.off(()=>const LoginView());
                        },
                        child: Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(text: AppStringsManager.have_account,style: getRegularStyle(
                                      color: Theme.of(context).textTheme.subtitle2!.color,
                                      fontSize: 12.sp
                                  )),
                                  TextSpan(text: AppStringsManager.login,style:getRegularStyle(
                                      color:  Theme.of(context).textTheme.subtitle1!.color,
                                      fontSize: 12.sp
                                  ))
                                ]
                            )
                        ))
                  ],
                ),

      ],
    ),
              ),
              Column(
                children: [
                  Text(AppStringsManager.accept_our_licence,style: getRegularStyle(
                      color: Theme.of(context).textTheme.subtitle2!.color,
                      fontSize: 10.sp
                  )),
                  Text(AppStringsManager.licence_and_condition_use,style: getRegularStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10.sp
                  )),
                   const SizedBox(
                    height: AppSize.s20,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
