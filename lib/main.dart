import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'language/locale_string.dart';
import 'providers/chat_provider.dart';
import 'providers/models_provider.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: GetMaterialApp(
          translations: LocalString(),
          locale: const Locale('en', 'US'),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: scaffoldBackgroundColor,
              appBarTheme: AppBarTheme(
                color: cardColor,
              )),
          home: const MenuScreen()),
    );
  }
}
