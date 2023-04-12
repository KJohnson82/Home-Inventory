import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hvtest1/theme.dart';
import 'Routes/Homes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'theme.dart';

// var homes = <int, Home>{};
FirebaseFirestore db = FirebaseFirestore.instance;

// final ThemeData appTheme = ThemeData(
//   colorScheme: ColorScheme(
//     brightness: Brightness.dark,
//     primary: const Color(0xFF344955),
//     onPrimary: Colors.white,
//     // secondary: Colors.cyan.shade700,
//     secondary: Color(0xFFF9AA33),
//     onSecondary: Colors.black,
//     tertiary: Colors.cyan.shade700,
//     // tertiary: Color(0xFFF9AA33),
//     onTertiary: Colors.black,
//     error: Colors.redAccent,
//     onError: Colors.black,
//     background: Colors.white,
//     // background: Color(0xFF344955),
//     onBackground: Colors.white,
//     surface: Color(0xFFF9AA33),
//     onSurface: Color(0xFF232323),
//   ),
//   textTheme: GoogleFonts.rubikTextTheme(),
// );

// final ThemeData appTheme = ThemeData(
//   colorScheme: ColorScheme.fromSwatch( primarySwatch: Colors.amber, primaryColorDark: Colors.cyan.shade800, accentColor: Colors.blueGrey, cardColor: Colors.amber.shade400, errorColor: Colors.redAccent,),
//   textTheme: GoogleFonts.poppinsTextTheme(),
//   cardTheme: CardTheme(
//
//   )
// );



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      theme: FlexThemeData.light(
        // colors: homeventory,
      ),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.tealM3),
      title: 'HOMVENTORY',
      // theme: appTheme,
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          notchMargin: 10,
          shape: AutomaticNotchedShape(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30),)
            ),
                StadiumBorder(),
          ),
        ),
        appBar: AppBar(
          title: const Text('HOMEVENTORY'),
          centerTitle: true,
        ),
        body: HomesPage(),
      ),
    ),
  );
}
