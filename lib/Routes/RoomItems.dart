import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeinventory/main.dart';
import 'itemForm.dart';
import 'Homes.dart';
import 'Rooms.dart';
// import 'package:homeinventory/Routes/itemForm.dart';
//
// import 'itemFormX.dart';



class RoomItem {
  int? itemId;
  String? itemDesc;  //Item Name
  List<Item>? items;

  RoomItem({
    required this.itemId,
    required this.itemDesc, //Item Name
    this.items

  });
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
//     this.itemDimensions,
//     this.itemNotes,
//     // this.itemImage,
//   });
// }
//
// class ItemController extends GetxController {
//   final items = <Item>[].obs;
//
//   void addItem(Item item) {
//     items.add(item);
//   }
// }


class RoomItemController extends GetxController {
  var highestId = 0.obs;
  // var items = <Item>[].obs;
  get roomItems => ItemController().items;

  void addRoomItem(String itemName) {
    if (roomItems.length < 50) {
      int newId = (highestId.value + 1);
      // items.add(RoomItem(itemId: newId, items: items, itemDesc: items.));
      itemName = ItemController().items[0].itemName!;
      highestId.value = newId;
    }
  }
}

void main() => runApp(const GetMaterialApp(home: RoomsPage()));

class RoomItemPage extends StatelessWidget {
  const RoomItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TextEditingController _itemName = TextEditingController();
    final ItemController itemController = Get.put(ItemController());

    return GetBuilder<RoomItemController>(
        init: RoomItemController(),
        builder: (controller) {
          return GetMaterialApp(
            title: 'Items',
            home: Scaffold(
              appBar: AppBar(
                title: const Text('HOMEVENTORY'),
                centerTitle: true,
              ),
              body: Obx(
                    () => GridView.builder(
                    padding: const EdgeInsets.all(100),
                    itemCount: controller.roomItems.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 40,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.fromLTRB(120, 100, 120 , 100),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15),
                          shape: BoxShape.rectangle,
                        ),
                        child: Text(controller.roomItems[index].itemName ?? ''),
                      );
                    }),
              ),
              floatingActionButton: Obx(() => FloatingActionButton.large(
                elevation: 4,
                foregroundColor: Colors.white,
                onPressed: controller.roomItems.length >= 10
                    ? null :
                    () => Get.to(() => ItemFormPage()),
                //     : () {
                //   showDialog(
                //       context: context,
                //       builder: (context) {
                //         return AlertDialog(
                //           title: const Text('Enter New Room Name: '),
                //           content: TextField(
                //             controller: _itemName,
                //             decoration: const InputDecoration(
                //                 hintText: 'Item Name'),
                //           ),
                //           actions: [
                //             ElevatedButton(
                //               onPressed: () {
                //                 controller.addRoomItem(_itemName.text);
                //                 Navigator.pop(context);
                //               },
                //               child: const Text('Save'),
                //             )
                //           ],
                //         );
                //       });
                // },
                child: const Icon(Icons.add_box_outlined),
              )),
            ),
          );
        });
  }
}