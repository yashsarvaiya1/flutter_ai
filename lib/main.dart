import 'package:api_demo/core/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Apis",
      initialBinding: AppBinding(),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.home,
      theme: ThemeData(
        fontFamily: GoogleFonts.robotoMono().fontFamily,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF009688), // Teal (Material base teal)
          onPrimary: Color(0xFFFFFFFF), // White text on teal

          secondary: Color(0xFF4DB6AC), // Lighter teal accent
          onSecondary: Color(0xFF00332F), // Deep teal text on secondary

          surface: Color(0xFFE0F2F1), // Very light teal for background surfaces
          onSurface: Color(0xFF1A1A1A), // Neutral dark text on light surface

          error: Color(0xFFD32F2F), // Rich red for errors
          onError: Color(0xFFFFFFFF), // White text on error background

          tertiary: Color(0xFF80CBC4), // Soft pastel teal (for tags, chips)
          onTertiary: Color(
            0xFF00251A,
          ), // Deep forest contrast for tertiary   // Standard readable black
        ),
      ),
    );
  }
}
