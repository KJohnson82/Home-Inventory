// import 'dart:html';
import 'package:flutter/material.dart';
// import 'package:firebase_core_web/firebase_core_web_interop.dart';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'Routes/itemForm.dart';
import 'Theme/colorTheme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:homeinventory/Routes/Homes.dart';
import 'package:get/get.dart';


class House {
  int? homeId;
  String? homeName;
  List<Room>? rooms;

  House({this.homeId, this.homeName, this.rooms});
}

List<House> _homes = [];

class Room {
  int? roomId;
  String? roomName;
  List<Item>? items;

  Room({this.roomId, this.roomName, this.items});
}

List<Room> _rooms = [];

class Item {
  int? itemId;
  String? itemName;
  String? itemType;
  String? itemSubtype;
  String? itemBrand;
  String? itemModel;
  String? itemDimensions;
  String? itemNotes;
  // File? itemImage;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemType,
    this.itemSubtype,
    this.itemBrand,
    this.itemModel,
    required this.itemDimensions,
    this.itemNotes,
    // this.itemImage,
  });
}

List<Item> _items = [];

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DynamicColorBuilder(
//       builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
//         ColorScheme lightScheme;
//         ColorScheme darkScheme;
//
//         if (lightDynamic != null && darkDynamic != null) {
//           lightScheme = lightDynamic.harmonized();
//           // lightCustomColors = lightCustomColors.harmonized(lightScheme);
//
//           // Repeat for the dark color scheme.
//           darkScheme = darkDynamic.harmonized();
//           // darkCustomColors = darkCustomColors.harmonized(darkScheme);
//         } else {
//           // Otherwise, use fallback schemes.
//           lightScheme = lightColorScheme;
//           darkScheme = darkColorScheme;
//         }
//
//         return MaterialApp(
//           theme: ThemeData(
//             useMaterial3: true,
//             colorScheme: lightScheme,
//             // extensions: [lightCustomColors],
//           ),
//           darkTheme: ThemeData(
//             useMaterial3: true,
//             colorScheme: darkScheme,
//             // extensions: [darkCustomColors],
//           ),
//           home: const Home(),
//         );
//       },
//     );
//   }
// }
//
// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 2,
//         title: const Text('Homeventory'),
//       ),
//       body: SizedBox(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ItemForm(),
//             Center(
//               child: Text('Hello World'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
