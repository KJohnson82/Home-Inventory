import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeinventory/main.dart';
import 'Homes.dart';
import 'Rooms.dart';
import 'package:homeinventory/itemForm.dart';

class Item {
  int? itemId;
  String? itemDisc;
  String? itemType;
  String? itemSubtype;
  String? itemBrand;
  String? itemModel;
  String? itemDimensions;
  String? itemNotes;
  // File? itemImage;

  Item({
    required this.itemId,
    required this.itemDisc,
    required this.itemType,
    this.itemSubtype,
    this.itemBrand,
    this.itemModel,
    required this.itemDimensions,
    this.itemNotes,
    // this.itemImage,
  });
}

class ItemController extends GetxController {
  var highestId = 0.obs;
  var items = <Item>[].obs;

  void addItem(String itemName) {
    if (items.length < 10) {
      int newId = (highestId.value + 1);
      items.add(Item(itemId: newId, itemDisc: itemName, itemType: , items: []));
      highestId.value = newId;
    }
  }
}

void main() => runApp(const GetMaterialApp(home: RoomsPage()));

class RoomsPage extends StatelessWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _itemName = TextEditingController();

    return GetBuilder<RoomController>(
        init: RoomController(),
        builder: (controller) {
          return MaterialApp(
            title: 'Material App',
            home: Scaffold(
              appBar: AppBar(
                title: const Text('HOMEVENTORY'),
                centerTitle: true,
              ),
              body: Obx(
                    () => GridView.builder(
                    padding: const EdgeInsets.all(100),
                    itemCount: controller.rooms.length,
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
                        child: Text(controller.rooms[index].roomDisc ?? ''),
                      );
                    }),
              ),
              floatingActionButton: Obx(() => FloatingActionButton.large(
                elevation: 4,
                foregroundColor: Colors.white,
                onPressed: controller.rooms.length >= 10
                    ? null
                    : () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Enter New Room Name: '),
                          content: TextField(
                            controller: _roomName,
                            decoration: const InputDecoration(
                                hintText: 'Room Name'),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                controller.addRoom(_roomName.text);
                                Navigator.pop(context);
                              },
                              child: const Text('Save'),
                            )
                          ],
                        );
                      });
                },
                child: const Icon(Icons.add_home_work_outlined),
              )),
            ),
          );
        });
  }
}