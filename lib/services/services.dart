import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../widgets/drop_down_widgets.dart';
import '../widgets/text_widgets.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: TextWidget(
                label: 'chosen_model'.tr,
                fontSize: 16,
              )),
              const Flexible(flex: 2, child: ModelDrowDownWidgets())
            ],
          ),
        );
      },
    );
  }
}
