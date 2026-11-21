import 'package:camera/camera.dart';
import 'package:chordefine/constants/color.dart';
import 'package:chordefine/models/onboarding_view.dart';
import 'package:chordefine/screens/base_screen.dart';
import 'package:chordefine/screens/major2.dart';
import 'package:chordefine/screens/minor2.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

void main() async {
  Get.lazyPut(() => PracticeScreenMajorController());
  Get.lazyPut(() => PracticeScreenMinorController());
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  cameras = await availableCameras();

  if (!onboarding) {
    await requestPermissions();
  }
  runApp(MyApp(onboarding: onboarding));
}

late List<CameraDescription> cameras;

Future<void> requestPermissions() async {
  await [
    Permission.camera,
    Permission.microphone,
  ].request();
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chordefine',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
          primary: primaryColor,
          secondary: kSecondaryColor,
          surface: kBgLight,
        ),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            color: kTextPrimary,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            color: kTextPrimary,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: kTextPrimary,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kTextSecondary,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: kTextSecondary,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: kTextPrimary,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
        scaffoldBackgroundColor: kBgLight,
      ),
      home: onboarding ? const BaseScreen() : const OnboardingView(),
    );
  }
}
