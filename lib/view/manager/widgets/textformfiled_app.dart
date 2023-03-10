import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinkey/view/resourse/assets_manager.dart';
import 'package:pinkey/view/resourse/color_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

class TextFiledApp extends StatefulWidget {
  TextFiledApp(
      {Key? key,
      this.textInputAction = TextInputAction.next,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.iconData,
      this.hintText,
      this.obscureText = false,
      this.suffixIcon = false,
      this.validator,
      this.onChanged,
      this.onTap,
      this.autofocus = false,
      this.readOnly = false,
      this.maxline = 1,
      this.minline = 1})
      : super(key: key);

  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final IconData? iconData;
  final String? hintText;
  final bool suffixIcon;
  final bool autofocus;
  final bool readOnly;
  bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final int? maxline;
  final int? minline;

  @override
  State<TextFiledApp> createState() => _TextFiledAppState();
}

class _TextFiledAppState extends State<TextFiledApp> {
  void showPassword() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxline,
      minLines: widget.minline,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      validator: widget.validator ??
          (String? val) {
            if (val!.trim().isEmpty) return AppStringsManager.field_required;
            return null;
          },
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      style: TextStyle(fontSize: SizerUtil.width / 30),
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 12.sp, color: ColorManager.hintColor),
          prefixIcon: widget.iconData == null
              ? null
              : Icon(
                  widget.iconData,
                  size: SizerUtil.width / 24,
                ),
          suffixIcon: widget.suffixIcon
              ? Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: InkWell(
                    onTap: () {
                      showPassword();
                    },
                    child: SvgPicture.asset(
                      AssetsManager.show_passwordIMG,
                      color: !widget.obscureText
                          ? ColorManager.primaryColor
                          : ColorManager.hintColor,
                    ),
                  ),
                )
              : null,
          hintText: widget.hintText),
    );
  }
}
