import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color scaffoldBackgroundColor = const Color(0xFF343541);
Color cardColor = const Color(0xFF444654);

var sizes = ['small'.tr, "medium".tr, "large".tr];
var values = ["256x256", "512x512", "1024x1024"];

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Horizon',
);

void showCustomFlushbar(BuildContext context, {required String title, required String message, required List<Color> colors}) {
  Flushbar(
    borderRadius: BorderRadius.circular(8),
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(10),
    backgroundGradient: LinearGradient(
      colors: colors,
      stops: const [0.4, 0.7, 1],
    ),
    boxShadows: const [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: title,
    message: message,
    messageSize: 17,
  ).show(context);
}



// List<String> models = [
//   'Model1',
//   'Model2',
//   'Model3',
//   'Model4',
//   'Model5',
//   'Model6',
// ];

// List<DropdownMenuItem<String>>? get getModelsItem {
//   List<DropdownMenuItem<String>>? modelsItems = List<DropdownMenuItem<String>>.generate(
//       models.length,
//       (index) => DropdownMenuItem(
//           value: models[index],
//           child: TextWidget(
//             label: models[index],
//             fontSize: 15,
//           )));
//   return modelsItems;
// }

// final chatMessages = [
//   {
//     "msg": "Hello who are you?",
//     "chatIndex": 0,
//   },
//   {
//     "msg":
//         "Hello, I am ChatGPT, a large language model developed by OpenAI. I am here to assist you with any information or questions you may have. How can I help you today?",
//     "chatIndex": 1,
//   },
//   {
//     "msg": "What is flutter?",
//     "chatIndex": 0,
//   },
//   {
//     "msg":
//         "Flutter is an open-source mobile application development framework created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web. Flutter uses the Dart programming language and allows for the creation of high-performance, visually attractive, and responsive apps. It also has a growing and supportive community, and offers many customizable widgets for building beautiful and responsive user interfaces.",
//     "chatIndex": 1,
//   },
//   {
//     "msg": "Okay thanks",
//     "chatIndex": 0,
//   },
//   {
//     "msg": "You're welcome! Let me know if you have any other questions or if there's anything else I can help you with.",
//     "chatIndex": 1,
//   },
// ];
