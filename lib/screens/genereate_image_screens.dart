import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';
import '../services/api_service.dart';
import '../widgets/generated_text_widget.dart';
import '../widgets/lottie_and_animated_text_kit_widget.dart';
import '../widgets/text_widgets.dart';

class GenerateImageScreen extends StatefulWidget {
  const GenerateImageScreen({super.key});

  @override
  State<GenerateImageScreen> createState() => _GenerateImageScreenState();
}

class _GenerateImageScreenState extends State<GenerateImageScreen> {
  void saveImage() async {
    await GallerySaver.saveImage(image, albumName: "Chat GPT App");
  }

  String dropValue = "512x512";
  var textControlller = TextEditingController();
  String image = '';
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(centerTitle: true, title: TextWidget(label: 'ai_image_generator'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Expanded(child: GeneratedTextWidget(textControlller: textControlller)),
                  const SizedBox(
                    width: 12,
                  ),
                  selectSizeMethod()
                ],
              ),
              generateButton(context)
            ],
          )),
          Expanded(
              flex: 4,
              child: isLoaded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imageFromAI(),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(child: downloadImageButton()),
                            const SizedBox(
                              width: 30,
                            ),
                          ],
                        )
                      ],
                    )
                  : const LottieAndAnimatedTextKitWidget()),
        ]),
      ),
    );
  }

  ElevatedButton downloadImageButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10), backgroundColor: btnColor, shape: const StadiumBorder()),
        onPressed: () {
          if (textControlller.text.isNotEmpty && dropValue.isNotEmpty) {
            saveImage();
            showCustomFlushbar(context, title: 'downloaded'.tr, message: 'photo_uploaded_to_gallery'.tr, colors: succesColor);
          } else {
            showCustomFlushbar(context, title: 'empty'.tr, message: 'not_image_err_msg'.tr, colors: errorColor);
          }
        },
        child: TextWidget(
          label: 'download'.tr,
        ));
  }

  Container imageFromAI() {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Image.network(
          image,
          fit: BoxFit.contain,
        ));
  }

  SizedBox generateButton(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 44,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: btnColor, shape: const StadiumBorder()),
            onPressed: () async {
              if (textControlller.text.isNotEmpty && dropValue.isNotEmpty) {
                setState(() {
                  isLoaded = false;
                });
                image = await ApiService.generateImage(textControlller.text, dropValue);
                setState(() {
                  isLoaded = true;
                });
              } else {
                showCustomFlushbar(context, title: 'empty_text'.tr, message: 'empty_text_err_msg'.tr, colors: errorColor);
              }
            },
            child: TextWidget(label: 'generate'.tr)));
  }

  Container selectSizeMethod() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
        dropdownColor: scaffoldBackgroundColor,
        icon: const Icon(
          Icons.expand_more,
          color: btnColor,
        ),
        value: dropValue,
        //hint: const Text("Select size"),
        items: List.generate(
            sizes.length,
            (index) => DropdownMenuItem(
                alignment: Alignment.center,
                value: values[index],
                child: Text(
                  sizes[index],
                  style: const TextStyle(color: Colors.white),
                ))),
        onChanged: (value) {
          setState(() {
            dropValue = value.toString();
          });
        },
      )),
    );
  }
}
