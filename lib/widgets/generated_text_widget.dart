import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class GeneratedTextWidget extends StatelessWidget {
  const GeneratedTextWidget({
    super.key,
    required this.textControlller,
  });

  final TextEditingController textControlller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          TextFormField(controller: textControlller, cursorColor: btnColor, decoration: InputDecoration(hintText: 'eg'.tr, border: InputBorder.none)),
    );
  }
}
