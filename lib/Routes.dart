import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Routes/Homes.dart';
import 'Routes/RoomItems.dart';
import 'Routes/Rooms.dart';
import 'Routes/itemForm.dart';



class Routes {
  // Static String  = ''; // Route template
  static String homePage = '/Homes';
  static String roomPage = '/Rooms';
  static String roomItemPage = '/RoomItems';
  static String itemForm = '/ItemForm';
  // static String loginPage = '/Login';
}

final getPages = [
  GetPage(name: Routes.homePage, page: () => HomesPage()),
  GetPage(name: Routes.roomPage, page: () => RoomsPage()),
  GetPage(name: Routes.roomItemPage, page: () => RoomItemsPage()),
  GetPage(name: Routes.itemForm, page: () => ItemFormPage()),
  // GetPage(name: Routes.loginPage, page: () => LoginPage()),
];