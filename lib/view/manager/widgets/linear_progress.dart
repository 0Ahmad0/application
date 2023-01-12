import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:pinkey/view/resourse/color_manager.dart';

class LinearProgress extends StatelessWidget {
  final int currentStep;
  final int maxSteps;
  final double minHeight;
  final Color progressColor;
  final Color backgroundColor;

  const LinearProgress(
      {super.key,
      required this.currentStep,
      required this.maxSteps,
      required this.minHeight,
       this.progressColor = ColorManager.thirdlyColor,
       this.backgroundColor = ColorManager.thirdlyColor
      });

  @override
  Widget build(BuildContext context) {
    return LinearProgressBar(
      minHeight: minHeight,
      maxSteps: maxSteps,
      currentStep: currentStep,
      progressColor: progressColor,
      backgroundColor: backgroundColor.withOpacity(.35),
    );
  }
}
