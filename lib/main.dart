
import 'package:flutter/material.dart';
// import 'package:firebase_core_web/firebase_core_web_interop.dart';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'Routes/RoomItems.dart';
import 'Routes/Rooms.dart';
import 'Routes/itemForm.dart';
import 'Theme/colorTheme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:homeinventory/Routes/Homes.dart';
import 'package:get/get.dart';



// class Item {
//   int? itemId;
//   String? itemName;
//   String? itemType;
//   String? itemSubtype;
//   String? itemBrand;
//   String? itemModel;
//   String? itemDimensions;
//   String? itemNotes;
//   // File? itemImage;
//
//   Item({
//     required this.itemId,
//     required this.itemName,
//     required this.itemType,
//     this.itemSubtype,
//     this.itemBrand,
//     this.itemModel,
//     required this.itemDimensions,
//     this.itemNotes,
//     // this.itemImage,
//   });
// }

// List<Item> _items = [];



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

// Home home = Get.arguments as Home;
// Room room = Get.arguments as Room;
// Item item = Get.arguments as Item;

void main() => runApp(GetMaterialApp(
  initialBinding: BindingsBuilder(() {
    Get.put(HomeController());
    Get.put(RoomController());
    Get.put(RoomItemController());
    // Get.put(ItemFormController());
    // Get.put(LoginController());


  }),
  defaultTransition: Transition.rightToLeft,
  transitionDuration: Duration(milliseconds: 200),
  home: HomesPage(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: HomesPage(),
      ),
    );
  }
}
