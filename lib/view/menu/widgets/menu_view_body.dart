import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinkey/view/complaint/complaint_view.dart';
import 'package:pinkey/view/login/login_view.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:pinkey/view/wallet/wallet_view.dart';
import 'package:sizer/sizer.dart';

class MenuViewBody extends StatelessWidget {
  bool not_login = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
        Text(
          AppStringsManager.menu,
          style: getRegularStyle(color: ColorManager.black, fontSize: 14.sp),
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
        InkWell(
          onTap: () => Get.off(() => LoginView(), transition: Transition.size),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
            decoration: BoxDecoration(
              color: ColorManager.primaryColor,
              borderRadius: BorderRadius.circular(6.sp),
            ),
            child: ListTile(
              leading: Container(
                alignment: Alignment.center,
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                    color: ColorManager.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.add_circle_outlined,
                  color: ColorManager.white,
                  size: 24.sp,
                ),
              ),
              title: Text(
                '${AppStringsManager.login + ' / ' + AppStringsManager.sign_up}',
                style: getRegularStyle(color: ColorManager.white),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                child: Text(
                  AppStringsManager.join_to_control_the_options,
                  style: getRegularStyle(
                      color: ColorManager.white, fontSize: 10.sp),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Divider(
          thickness: .9,
          color: ColorManager.hintColor,
        ),
        /// here on login will be show
        Visibility(
          visible: not_login,
          child: buildMenuListTile(
            onTap: () {
              //TODO: Navigator
            },
            image: AssetsManager.profileIMG,
            title: AppStringsManager.profile,
            subtitle: AppStringsManager.profile_subtitle,
          ),
        ),
        Visibility(
          visible: not_login,
          child: const SizedBox(
            height: AppSize.s20,
          ),
        ),
        ///
        Visibility(
          visible: not_login,
          child: buildMenuListTile(
            onTap: () {
              Get.to(()=>WalletView(),transition: Transition.upToDown);
            },
            image: AssetsManager.walletIMG,
            title: AppStringsManager.wallet,
            subtitle: AppStringsManager.wallet_subtitile,
          ),
        ),
        Visibility(
          visible: not_login,
          child: const SizedBox(
            height: AppSize.s20,
          ),
        ),
        ///
        Visibility(
          visible: not_login,
          child: buildMenuListTile(
            onTap: () {
              Get.to(()=>ComplaintView(),transition: Transition.upToDown);
            },
            image: AssetsManager.send_complaintIMG,
            title: AppStringsManager.send_complaint,
            subtitle: AppStringsManager.send_complaint_subtitle,
          ),
        ),
        Visibility(
          visible: not_login,
          child: const SizedBox(
            height: AppSize.s20,
          ),
        ),
        /// here on login will be show
        buildMenuListTile(
          onTap: () {
            //TODO: Navigator
          },
          image: AssetsManager.connection_customer_servicesIMG,
          title: AppStringsManager.contact_customer_service,
          subtitle: AppStringsManager.contact_customer_service_subtitle,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        ///
        buildMenuListTile(
          onTap: () {
            //TODO: Navigator
          },
          image: AssetsManager.languageIMG,
          title: AppStringsManager.language,
          subtitle: AppStringsManager.language_subtitle,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        ///
        buildMenuListTile(
          onTap: () {
            //TODO: Navigator
          },
          image: AssetsManager.terms_of_useIMG,
          title: AppStringsManager.terms_of_use,
          subtitle: AppStringsManager.terms_of_use_subtitle,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        ///
        buildMenuListTile(
          onTap: () {
            //TODO: Navigator
          },
          image: AssetsManager.privacy_policyIMG,
          title: AppStringsManager.privacy_policy,
          subtitle: AppStringsManager.privacy_policy_subtitle,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        ///
        Visibility(
          visible: not_login,
          child: buildMenuListTile(
            onTap: () {
              //TODO: Navigator
            },
            image: AssetsManager.log_outIMG,
            title: AppStringsManager.log_out,
            subtitle: AppStringsManager.log_out_subtitle,
          ),
        ),
        Visibility(
          visible: not_login,
          child: const SizedBox(
            height: AppSize.s20,
          ),
        ),
        ///
        Divider(
          thickness: .9,
          color: ColorManager.hintColor,
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Container(
          padding: const EdgeInsets.all(AppPadding.p20),
          decoration: BoxDecoration(
            color: ColorManager.secondaryColor,
            borderRadius: BorderRadius.circular(6.sp),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  AppStringsManager.join_as_a_coach,
                  style: getRegularStyle(color: ColorManager.white),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p60, top: AppPadding.p10),
                  child: Text(
                    AppStringsManager.offer_courses_and_assistance,
                    style: getRegularStyle(
                        color: ColorManager.white, fontSize: 10.sp),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: (SizerUtil.width / 2) - 32.0,
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: BoxDecoration(
                          color: ColorManager.thirdlyColor,
                          borderRadius: BorderRadius.circular(6.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStringsManager.join_now,
                            style: getRegularStyle(
                                color: ColorManager.white, fontSize: 12.sp),
                          ),
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: ColorManager.white,
                            size: 12.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class buildMenuListTile extends StatelessWidget {
  final VoidCallback onTap;
  final String image, title, subtitle;

  const buildMenuListTile(
      {super.key,
      required this.onTap,
      required this.image,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 20.sp,
        backgroundColor: ColorManager.borderColor,
        child: SvgPicture.asset(image,color: ColorManager.black,),
      ),
      title: Text(title),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
        child: Text(
          subtitle,
          style: TextStyle(color: ColorManager.lightGray),
        ),
      ),
      trailing: Icon(
        Icons.arrow_back_ios_new,
        color: ColorManager.black,
        size: 14.sp,
      ),
    );
  }
}
