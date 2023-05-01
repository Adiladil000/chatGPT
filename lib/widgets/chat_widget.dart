import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../services/assets_manager.dart';
import 'text_widgets.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget({super.key, required this.msg, required this.chatIndex, this.shouldAnimate = false});
  String? copy;
  final String msg;
  final int chatIndex;
  final bool shouldAnimate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0 ? AssetsManager.userImage : AssetsManager.botImage,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: chatIndex == 0
                        ? TextWidget(
                            label: msg,
                          )
                        : DefaultTextStyle(
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                            child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                repeatForever: false,
                                displayFullTextOnTap: true,
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    msg.trim(),
                                  ),
                                ]),
                          )),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: msg)).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Center(
                                    child: TextWidget(
                                      label: 'copied_to_clipboard'.tr,
                                    ),
                                  ))));
                            },
                            icon: const Icon(Icons.copy, color: Colors.white),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
