import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';
import '../providers/chat_provider.dart';
import '../providers/models_provider.dart';
import '../services/assets_manager.dart';
import '../services/services.dart';
import '../widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    textEditingController = TextEditingController();
    _listScrollController = ScrollController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    _listScrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  //List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ChatGPT"),
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.openaiLogo),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await Services.showModalSheet(context: context);
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          Flexible(
            child: ListView.builder(
              controller: _listScrollController,
              itemCount: chatProvider.getChatList.length, //chatList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                    msg: chatProvider.getChatList[index].msg, //chatList[index].msg,
                    chatIndex: chatProvider.getChatList[index].chatIndex //chatList[index].chatIndex,
                    );
              },
            ),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
          ],
          const SizedBox(
            height: 15,
          ),
          Material(
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    focusNode: focusNode,
                    style: const TextStyle(color: Colors.white),
                    controller: textEditingController,
                    onSubmitted: (value) async {
                      await sendMessageFCT(modelsProvider: modelsProvider, chatProvider: chatProvider);
                    },
                    decoration: InputDecoration.collapsed(hintText: 'help_message'.tr, hintStyle: const TextStyle(color: Colors.grey)),
                  )),
                  IconButton(
                      onPressed: () async {
                        await sendMessageFCT(modelsProvider: modelsProvider, chatProvider: chatProvider);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  Future<void> sendMessageFCT({required ModelsProvider modelsProvider, required ChatProvider chatProvider}) async {
    if (_isTyping) {
      showCustomFlushbar(
        context,
        title: "mistake".tr,
        message: 'multi_mes_err'.tr,
        colors: errorColor,
      );
      return;
    }

    if (textEditingController.text.isEmpty) {
      showCustomFlushbar(context, title: 'empty'.tr, message: 'empty_err_msg'.tr, colors: errorColor);
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        //    chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });

      await chatProvider.sendMessageAndGetAnswer(
        msg: msg,
        chosenModelId: modelsProvider.getCurrentModel,
      );
      // chatList.addAll(await ApiService.sendMessage(
      //   message: textEditingController.text,
      //   modelId: modelsProvider.getCurrentModel,
      // ));
      setState(() {});
    } catch (e) {
      log("xeta $e");
      showCustomFlushbar(context, title: 'mistake'.tr, message: 'unexpected_error_occurred'.tr, colors: errorColor);
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
