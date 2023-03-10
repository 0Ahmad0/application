import 'package:flutter/material.dart';
import '/view/resourse/color_manager.dart';
import 'package:sizer/sizer.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp({Key? key,
     this.color = ColorManager.primaryColor,
    required this.text,
     this.radius = 4.0,
    required this.onPressed, this.textColor = ColorManager.white,
     this.width = double.infinity,
     this.height =60,
     this.fontSize,
    this.borderColor = Colors.transparent,
  }) : super(key: key);
  final Color? color;
  final Color? textColor;
  final Color borderColor;
  final String text;
  final double? radius;
  final double width;
  final double height;
  final double? fontSize;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: color,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
          side: BorderSide(color: borderColor)
        )
      ),
      onPressed: onPressed,
      child: FittedBox(
        child: Text(text,style: TextStyle(
          color: textColor,
          fontSize: fontSize??14.sp
        ),),
      ),
    );
  }
}
