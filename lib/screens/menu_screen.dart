import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../services/assets_manager.dart';
import '../widgets/text_widgets.dart';
import 'chat_screen.dart';
import 'genereate_image_screens.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Azərbaycan dili', 'locale': const Locale('az', 'AZ')},
    {'name': 'Pyccкий Язык', 'locale': const Locale('ru', 'RU')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  languageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(8),
          backgroundColor: Colors.blue.shade100,
          title: Center(
            child: Text(
              'choose_language'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        //    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade100, shape: const StadiumBorder()),
                        child: Text(locale[index]['name'], style: const TextStyle(color: btnColor, fontSize: 23)),
                        onPressed: () {
                          updateLanguage(locale[index]['locale']);
                        },
                      ));
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: btnColor,
                  );
                },
                itemCount: locale.length),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(fit: BoxFit.cover, AssetsManager.menu),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 300, height: 70, child: chatButton(context)),
            const SizedBox(
              height: 60,
            ),
            SizedBox(width: 300, height: 70, child: generateImageButton(context)),
            const SizedBox(
              height: 60,
            ),
            SizedBox(width: 300, height: 70, child: chooseLaguageButton()),
          ],
        ),
      ),
    ]));
  }

  ElevatedButton chooseLaguageButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shape: const StadiumBorder()),
        onPressed: () {
          languageDialog(context);
        },
        child: TextWidget(textalign: TextAlign.center, fontSize: 25, color: btnColor, label: 'choose_language'.tr));
  }

  ElevatedButton generateImageButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shape: const StadiumBorder()),
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (context) => const GenerateImageScreen(),
          );
          Navigator.push(context, route);
        },
        child: TextWidget(textalign: TextAlign.center, fontSize: 25, color: btnColor, label: 'generate_image'.tr));
  }

  ElevatedButton chatButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shape: const StadiumBorder()),
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          );
          Navigator.push(context, route);
        },
        child: TextWidget(textalign: TextAlign.center, fontSize: 25, color: btnColor, label: 'chat'.tr));
  }
}
