// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import 'Homes.dart';
// import 'ItemsForm.dart';
// import 'Rooms.dart';
// import 'RoomItems.dart';
// // import 'Routes/Homes.dart';
// // import 'Routes/RoomItems.dart';
// // import 'Routes/Rooms.dart';
// // import 'Routes/itemForm.dart';
//
// class Routes {
//   // Static String  = ''; // Route template
//   static String homePage = '/Homes';
//   static String roomPage = '/Rooms';
//   static String roomItemPage = '/RoomItems';
//   static String itemForm = '/ItemForm';
// // static String loginPage = '/Login';
// }
//
// final hvPages = [
//   ProviderScope(child: HomesPage()),
//   ProviderScope(child: RoomsPage()),
//   ProviderScope(child: RoomItemPage()),
//   ProviderScope(child: ItemFormPage(itemController: null,)),
// ];
//
// class RoomItemsPage {
// }
//
// void main() {
//   runApp(
//     ProviderScope(
//       child: MaterialApp(
//         title: 'Material App',
//         initialRoute: Routes.homePage,
//         routes: {
//           Routes.homePage: (_) => HomesPage(),
//           Routes.roomPage: (_) => RoomsPage(),
//           Routes.roomItemPage: (_) => RoomItemPage(),
//           Routes.itemForm: (_) => ItemFormPage(itemController: null,),
//         },
//       ),
//     ),
//   );
// }
