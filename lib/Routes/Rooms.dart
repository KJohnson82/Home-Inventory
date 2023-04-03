// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:homeinventory/main.dart';
// import 'Homes.dart';
// import 'RoomItems.dart';
//
// class Room {
//   int? roomId;
//   String? roomName;
//   List<Item>? items;
//
//   Room({this.roomId, this.roomName, this.items});
// }
//
// var home = Get.arguments as Home;
//
// class RoomController extends GetxController {
//   var highestId = 0.obs;
//   var rooms = <Room>[].obs;
//
//   void addRoom(String roomName) {
//     if (rooms.length < 10) {
//       int newId = (highestId.value + 1);
//       rooms.add(Room(roomId: newId, roomName: roomName, items: []));
//       highestId.value = newId;
//     }
//   }
// }
//
// void main() => runApp(GetMaterialApp(home: RoomsPage()));
//
// class RoomsPage extends StatelessWidget {
//   RoomsPage({Key? key}) : super(key: key);
//   final TextEditingController _roomName = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<RoomController>(
//       init: RoomController(),
//       builder: (controller) {
//         return MaterialApp(
//           title: 'Rooms',
//           home: Scaffold(
//             appBar: AppBar(
//               leading: BackButton(
//                 onPressed: () => Get.back(),
//               ),
//               title: Text('HOMEVENTORY: ${home.homeName}'),
//               centerTitle: true,
//             ),
//             body: Obx(
//               () => GridView.builder(
//                 padding: const EdgeInsets.all(50),
//                 itemCount: controller.rooms.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 40,
//                 ),
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Colors.amber,
//                       borderRadius: BorderRadius.circular(15),
//                       shape: BoxShape.rectangle,
//                     ),
//                     child: Text(controller.rooms[index].roomName ?? ''),
//                   );
//                 },
//               ),
//             ),
//             floatingActionButton: Obx(
//               () => FloatingActionButton.large(
//                 elevation: 4,
//                 foregroundColor: Colors.white,
//                 onPressed: controller.rooms.length >= 10
//                     ? null
//                     : () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: const Text("Enter New Room Name: "),
//                               content: TextField(
//                                 controller: _roomName,
//                                 decoration: const InputDecoration(
//                                     hintText: 'Room Name'),
//                                 focusNode: _focusNode,
//                                 autofocus: true,
//                                 onSubmitted: (value) {
//                                   controller.addRoom(_roomName.text);
//                                   _roomName.clear();
//                                   Navigator.pop(context);
//                                 },
//                                 onTap: () {
//                                   _focusNode.requestFocus();
//                                 },
//                                 onTapOutside: (event) {
//                                   _focusNode.unfocus();
//                                 },
//                               ),
//                               actions: [
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     controller.addRoom(_roomName.text);
//                                     _roomName.clear();
//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text("Save"),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                 child: const Icon(
//                   Icons.add_home_outlined,
//                   size: 60,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeinventory/main.dart';
import 'package:homeinventory/main.dart';
import '../main.dart';
import 'Homes.dart';
import 'RoomItems.dart';
import 'itemForm.dart';


class Room {
  int? roomId;
  String? roomName;
  Map<int, Item>? items;

  Room({this.roomId, this.roomName, Map<int, Item>? items}) {
    this.items = items ?? {};
}}


// var homeId = Home().homeId;
// var homeName = Get.parameters Home().homeName;
// var homeRooms = Home().rooms;
String? homeName = Get.parameters['homeName'];
String? homeId = Get.parameters['homeId'];
// String? homeRooms = Get.parameters[rooms];


class RoomController extends GetxController {
  var highestId = 0.obs;
  var rooms = <int, Room>{}.obs;

  void addRoom(int homeId, String roomName) {
    if (rooms.length < 10) {
      int newId = (highestId.value + 1);
      Room newRoom = Room(roomId: newId, roomName: roomName, items: {});
      rooms[newId] = newRoom;
      highestId.value = newId;
      // Home().rooms![newId] = newRoom;

      Get.find<HomeController>().homes[homeId]!.rooms![newId] = newRoom;

      print('$homeId + $homeName');
    }
  }

  // RoomController({required this.home});
}

void main() => runApp(GetMaterialApp(home: RoomsPage()));

class RoomsPage extends StatelessWidget {
  RoomsPage({Key? key}) : super(key: key);
  final TextEditingController _roomName = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  // final Home home;



  @override
  Widget build(BuildContext context) {


    // final home = Get.arguments as Home;
    // final roomController = Get.put(RoomController());
    return GetBuilder<RoomController>(
      init: RoomController(),
      builder: (controller) {
        return MaterialApp(
          title: 'Rooms',
          home: Scaffold(
            appBar: AppBar(
              title: Text('HOMEVENTORY: ${Get.parameters['homeName']}'),
              centerTitle: true,
              leading: BackButton(
                onPressed: () => Get.back(),
              ),
            ),
            body: Obx(
              () => GridView.builder(
                padding: const EdgeInsets.all(50),
                itemCount: controller.rooms.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // mainAxisSpacing: 20,
                  // crossAxisSpacing: 40,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final room = controller.rooms.values.toList()[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => RoomItemsPage());
                      print('This was pressed ${room.roomName}');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15),
                          shape: BoxShape.rectangle,
                        ),
                        child: Text(room.roomName ?? ''),
                      ),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: Obx(
              () => FloatingActionButton.large(
                elevation: 4,
                foregroundColor: Colors.white,
                onPressed: controller.rooms.length >= 10
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Enter New Room Name: "),
                              content: TextField(
                                controller: _roomName,
                                decoration: const InputDecoration(
                                    hintText: 'Room Name'),
                                focusNode: _focusNode,
                                autofocus: true,
                                onSubmitted: (value) {
                                  controller.addRoom(Get.find<HomeController>().highestId.value, _roomName.text);
                                  _roomName.clear();
                                  Navigator.pop(context);
                                },
                                onTap: () {
                                  _focusNode.requestFocus();
                                },
                                onTapOutside: (event) {
                                  _focusNode.unfocus();
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    controller.addRoom(Get.find<HomeController>().highestId.value, _roomName.text);
                                    _roomName.clear();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Save"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                child: const Icon(
                  Icons.add_home_outlined,
                  size: 60,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
