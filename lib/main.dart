import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hvtest1/theme.dart';
import 'Routes/Homes.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'theme.dart';
import 'package:page_transition/page_transition.dart';
import 'firestore_instance.dart';


// FirebaseFirestore db = FirebaseFirestore.instance;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseFirestore db = FirebaseFirestore.instance;
  // db.settings = const Settings(persistenceEnabled: true);

  await FirestoreInstance.setSettings(
    const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    )
  );

  runApp(
    MaterialApp(
      //Calls the theme from theme file to be used in th rest of the app
      theme: ThemeData.from(colorScheme: homeventory, useMaterial3: false, textTheme: GoogleFonts.poppinsTextTheme()),
      title: 'HOMVENTORY',
      home: Scaffold(
        appBar: AppBar(
          // Sets the phone icons to use dark mode
          systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
          backgroundColor: homeventory.primary,
          title: const Text('HOMEVENTORY', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold,)),
          centerTitle: true,
        ),
        // Launches the Homes Page as the main app page
        body: HomesPage(),
      ),
    ),
  );
}
