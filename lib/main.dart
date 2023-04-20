import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hvtest1/theme.dart';
import 'Routes/Homes.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'theme.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      theme: ThemeData.from(colorScheme: homeventory, useMaterial3: true, textTheme: GoogleFonts.poppinsTextTheme()),
      title: 'HOMVENTORY',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: homeventory.primary,
          title: const Text('HOMEVENTORY'),
          centerTitle: true,
        ),
        body: HomesPage(),
      ),
    ),
  );
}
