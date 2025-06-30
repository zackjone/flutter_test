

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_app/app_pages.dart';
import 'package:get/get.dart';

void main() async {
  runApp(MyApp());

}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: Get.deviceLocale,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('zh', 'CN'),
          Locale('en', 'US'),
        ],

        //语言映射表
        fallbackLocale: const Locale("zh", "CN"),
        //读取失败时候默认语言
        defaultTransition: Transition.rightToLeft,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeData(
          primaryColor: Color(0xFFC18121),
          tabBarTheme: const TabBarThemeData(dividerColor: Colors.transparent),
        ),
        initialRoute: '/',
        getPages: AppPages.getAllPages());
  }
}
