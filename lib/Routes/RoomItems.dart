// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:homeinventory/main.dart';
//
// import 'Rooms.dart';
//
// class RoomItem {
//   int? itemId;
//   String? itemName;
//   List<Item>? items;
//
//   RoomItem({this.itemId, this.itemName, this.items});
// }
//
// var room = Get.arguments as Room;
//
// class RoomItemController extends GetxController {
//   var highestId = 0.obs;
//   var roomItems = <RoomItem>[].obs;
//
//   void addItem(String itemName) {
//     if (roomItems.length < 10) {
//       int newId = (highestId.value + 1);
//       roomItems.add(RoomItem(itemId: newId, itemName: itemName, items: []));
//       highestId.value = newId;
//     }
//   }
// }
//
// // void main() => runApp(GetMaterialApp(home: RoomItemsPage()));
//
// class RoomItemsPage extends StatelessWidget {
//   RoomItemsPage({Key? key}) : super(key: key);
//   final TextEditingController _itemName = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<RoomItemController>(
//       init: RoomItemController(),
//       builder: (controller) {
//         return GetMaterialApp(
//           title: 'Items',
//           home: Scaffold(
//             appBar: AppBar(
//               leading: BackButton(
//                 onPressed: () => Get.back(),
//               ),
//               title: Text('HOMEVENTORY:  ${room.roomName}'),
//               centerTitle: true,
//             ),
//             body: Obx(
//               () => GridView.builder(
//                 padding: const EdgeInsets.all(50),
//                 itemCount: controller.roomItems.length,
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
//                     child: Text(controller.roomItems[index].itemName ?? ''),
//                   );
//                 },
//               ),
//             ),
//             floatingActionButton: Obx(
//               () => FloatingActionButton.large(
//                 elevation: 4,
//                 foregroundColor: Colors.white,
//                 onPressed: controller.roomItems.length >= 10
//                     ? null
//                     : () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: const Text("Enter New Item Name: "),
//                               content: TextField(
//                                 controller: _itemName,
//                                 decoration: const InputDecoration(
//                                     hintText: 'Item Name'),
//                                 focusNode: _focusNode,
//                                 autofocus: true,
//                                 onSubmitted: (value) {
//                                   controller.addItem(_itemName.text);
//                                   _itemName.clear();
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
//                                     controller.addItem(_itemName.text);
//                                     _itemName.clear();
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

import 'Rooms.dart';
import 'itemForm.dart';

class RoomItem {
  Item? item;
  // int? itemId;
  // String? itemName;
  Map<int, Item>? items;

  // RoomItem({this.itemId, this.itemName, this.items});
  RoomItem({this.items});

  String? get itemName => item?.itemName!;
}

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

// var room = Get.arguments as Room;

class RoomItemController extends GetxController with StateMixin<RoomItem>{
  Room? room;
  var highestId = 0.obs;
  var roomItems = <int, RoomItem>{}.obs;

  void addItem(Item item) {
    if (roomItems.length < 50) {
      int newId = (highestId.value + 1);
      roomItems[newId] = RoomItem(items: {});
      highestId.value = newId;
    }
  }
  RoomItemController({this.room});
}

class RoomItemsPage extends StatelessWidget {
  final Room room;

  RoomItemsPage({Key? key, required this.room}) : super(key: key);
  final TextEditingController _itemName = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Get.put(RoomItemController(room: room));
    return GetBuilder<RoomItemController>(
      // init: RoomItemController()..room = room,
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => Get.back(result: controller.roomItems),
              ),
              title: Text('HOMEVENTORY:  ${controller.room?.roomName}'),
              centerTitle: true,
            ),
            body: Obx(
                  () => ListView.builder(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                itemCount: controller.roomItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final roomItem = controller.roomItems.values.elementAt(index);
                  return Card(
                    // margin: EdgeInsets.fromLTRB(1, 5, 1, 5),
                    color: Colors.amber,
                    elevation: 2,
                    child: ListTile(
                      onTap: () {

                      },
                      onLongPress: () {

                      },
                      title: Text(_itemName.text ?? ''),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: Obx(
                  () => FloatingActionButton.large(
                elevation: 4,
                foregroundColor: Colors.white,
                    // onPressed: () => Get.to(ItemFormPage()),
                onPressed: controller.roomItems.length >= 50
                    ? null
                    : () async {
                  final Item? newItem = await Get.to(ItemFormPage());
                  if (newItem != null) {
                    controller.addItem(newItem);
                  }
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       title: const Text("Enter New Item Name: "),
                  //       content: TextField(
                  //         controller: _itemName,
                  //         decoration: const InputDecoration(
                  //             hintText: 'Item Name'),
                  //         focusNode: _focusNode,
                  //         autofocus: true,
                  //         onSubmitted: (value) {
                  //           controller.addItem(_itemName.text);
                  //           _itemName.clear();
                  //           Navigator.pop(context);
                  //         },
                  //         onTap: () {
                  //           _focusNode.requestFocus();
                  //         },
                  //         onTapOutside: (event) {
                  //           _focusNode.unfocus();
                  //         },
                  //       ),
                  //       actions: [
                  //         ElevatedButton(
                  //           onPressed: () {
                  //             controller.addItem(_itemName.text);
                  //             _itemName.clear();
                  //             Navigator.pop(context);
                  //           },
                  //           child: const Text("Save"),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
                },
                child: const Icon(
                  Icons.add_home_outlined,
                  size: 60,
              //   ),
              // ),
            ),
          ),
        ),
        );
      },
    );
  }
}
