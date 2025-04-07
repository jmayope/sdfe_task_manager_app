import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sdfe_task_manager_app/app/data/constants.dart';

import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge:  TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.bold
          ),
          bodyMedium: TextStyle(
            color: SECONDARY_COLOR
          ),
          titleLarge: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.bold
          ),
          titleMedium: TextStyle(
            color: SECONDARY_COLOR
          )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        primaryColor: fromHex('#7a8f79'),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: WidgetStateColor.resolveWith((c) => fromHex('#7a8f79')),
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700
            ),
            // iconColor: Colors.white
          )
        )
      ),
    ),
  );
}
