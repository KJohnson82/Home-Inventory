// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'Homes.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
//
// import 'RoomItems.dart';
// import 'Rooms.dart';
//
// var homes = <int, Home>{};
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   FirebaseDatabase database = FirebaseDatabase.instance;
//   DatabaseReference ref = FirebaseDatabase.instance.ref();
//
//   // DatabaseReference homesRef = FirebaseDatabase.instance.ref('homes');
//
//   runApp(
//     MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('HOMEVENTORY'),
//           centerTitle: true,
//         ),
//         body: HomesPage(),
//       ),
//     ),
//   );
// }
//
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'HOMEVENTORY',
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('HOMEVENTORY'),
// //         ),
// //         body: HomesPage(),
// //       ),
// //     );
// //   }
// // }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Homes.dart';

// var homes = <int, Home>{};
FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // FirebaseFirestore db = FirebaseFirestore.instance;
  // CollectionReference homesRef = FirebaseFirestore.instance.collection('homes');

  runApp(
    MaterialApp(
      title: 'Material App',
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
