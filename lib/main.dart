import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Homes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import 'Routes/RoomItems.dart';
// import 'Routes/Rooms.dart';
// import 'Routes/itemForm.dart';
// import 'Theme/colorTheme.dart';
// import 'package:dynamic_color/dynamic_color.dart';
// import 'package:homeinventory/Routes/Homes.dart';

import 'RoomItems.dart';
import 'Rooms.dart';

// await Firebase.initializeApp(
//
// options: DefaultFirebaseOptions.currentPlatform,
//
// );

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = FirebaseDatabase.instance.ref();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  runApp(
    MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOMEVENTORY'),
          centerTitle: true,
        ),
        body: HomesPage(),
      ),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'HOMEVENTORY',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('HOMEVENTORY'),
//         ),
//         body: HomesPage(),
//       ),
//     );
//   }
// }
