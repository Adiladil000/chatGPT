import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/constants.dart';

class LottieAndAnimatedTextKitWidget extends StatelessWidget {
  const LottieAndAnimatedTextKitWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: scaffoldBackgroundColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 30,
          ),
          Lottie.network(height: 240, "https://assets4.lottiefiles.com/packages/lf20_y5ljuke8.json"),
          const SizedBox(
            height: 80,
          ),
          Expanded(
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  textAlign: TextAlign.center,
                  'info_mes_1'.tr,
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  textAlign: TextAlign.center,
                  'info_mes_2'.tr,
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  textAlign: TextAlign.center,
                  'info_mes_3'.tr,
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
            ),
          )
        ],
      ),
    );
  }
}
