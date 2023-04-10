import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Routes/Homes.dart';
import 'package:google_fonts/google_fonts.dart';


// var homes = <int, Home>{};
FirebaseFirestore db = FirebaseFirestore.instance;

final ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: const Color(0xFF344955),
      onPrimary: Colors.white,
      // secondary: Colors.cyan.shade700,
      secondary: Color(0xFFF9AA33),
      onSecondary: Colors.black,
      tertiary: Colors.cyan.shade700,
      // tertiary: Color(0xFFF9AA33),
      onTertiary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.black,
      background: Colors.white,
      // background: Color(0xFF344955),
      onBackground: Colors.white,
      surface: Color(0xFFF9AA33),
      onSurface: Color(0xFF232323),
    ),
    textTheme: GoogleFonts.rubikTextTheme(),
);




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: 'HOMVENTORY',
      // theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HOMEVENTORY'),
          centerTitle: true,
        ),
        body: HomesPage(),
      ),
    ),
  );
}
