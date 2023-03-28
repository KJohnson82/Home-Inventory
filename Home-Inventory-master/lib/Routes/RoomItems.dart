import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeinventory/main.dart';
import 'Homes.dart';
import 'Rooms.dart';
import 'package:homeinventory/Routes/itemForm.dart';



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

class RoomItemController extends GetxController {
  var highestId = 0.obs;
  var items = <Item>[].obs;

  void addRoomItem(String itemName) {
    if (items.length < 50) {
      int newId = (highestId.value + 1);
      // items.add(RoomItem(itemId: newId, items: items, itemDesc: items.));
      items.add(Item(itemId: newId, itemName:_itemNamController.text, itemType: itemType, itemDimensions: itemDimensions));
      highestId.value = newId;
    }
  }
}

void main() => runApp(const GetMaterialApp(home: RoomsPage()));

class RoomItemPage extends StatelessWidget {
  const RoomItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _itemName = TextEditingController();

    return GetBuilder<RoomItemController>(
        init: RoomItemController(),
        builder: (controller) {
          return MaterialApp(
            title: 'Items',
            home: Scaffold(
              appBar: AppBar(
                title: const Text('HOMEVENTORY'),
                centerTitle: true,
              ),
              body: Obx(
                    () => GridView.builder(
                    padding: const EdgeInsets.all(100),
                    itemCount: controller.items.length,
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
                        child: Text(controller.items[index].itemName ?? ''),
                      );
                    }),
              ),
              floatingActionButton: Obx(() => FloatingActionButton.large(
                elevation: 4,
                foregroundColor: Colors.white,
                onPressed: controller.items.length >= 10
                    ? null
                    : () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Enter New Room Name: '),
                          content: TextField(
                            controller: _itemName,
                            decoration: const InputDecoration(
                                hintText: 'Item Name'),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                controller.addRoomItem(_itemName.text);
                                Navigator.pop(context);
                              },
                              child: const Text('Save'),
                            )
                          ],
                        );
                      });
                },
                child: const Icon(Icons.add_box_outlined),
              )),
            ),
          );
        });
  }
}