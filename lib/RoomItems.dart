import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'ItemsForm.dart';
import 'Rooms.dart';
import 'main.dart';
import 'Homes.dart';

class RoomItem {
  int? itemId;
  String? itemDesc; //Item Name
  List<Item>? items;

  RoomItem({
    required this.itemId,
    required this.itemDesc, //Item Name
    this.items,
  });
}

class RoomItemController {
  List<RoomItem> items = [];
  int highestId = 0;

//   void addRoomItem(String itemName) {
//     if (items.length < 50) {
//       int newId = (highestId + 1);
//       items.add(RoomItem(
//         itemId: newId,
//         itemDesc: itemName,
//         items: [],
//       ));
//       highestId = newId;
//       FirebaseDatabase.instance.ref().child('items').push().set({
//         'itemId': items[newId].itemId,
//         'itemName': items[newId].itemDesc,
//         'items': items[newId].items,
//       });
//     }
//   }
}

class RoomItemPage extends StatefulWidget {
  const RoomItemPage({Key? key}) : super(key: key);

  @override
  _RoomItemPageState createState() => _RoomItemPageState();
}

class _RoomItemPageState extends State<RoomItemPage> {
  final RoomItemController controller = RoomItemController();
  final ItemController _itemController = ItemController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOMEVENTORY'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          RoomItem roomItem = controller.items[index];
          return ExpansionTile(
            title: Text(roomItem.itemDesc ?? ''),
            children: roomItem.items?.map((item) {
              return Column(
                children: [
                  ListTile(
                    title: Text('Type: ${item.itemType ?? ''}'),
                  ),
                  ListTile(
                    title: Text('Subtype: ${item.itemSubtype ?? ''}'),
                  ),
                  ListTile(
                    title: Text('Brand: ${item.itemBrand ?? ''}'),
                  ),
                  ListTile(
                    title: Text('Model: ${item.itemModel ?? ''}'),
                  ),
                  ListTile(
                    title: Text('Dimensions: ${item.itemDimensions ?? ''}'),
                  ),
                  ListTile(
                    title: Text('Color: ${item.itemColor ?? ''}'),
                  ),
                  ListTile(
                    title: Text('Notes: ${item.itemNotes ?? ''}'),
                  ),
                ],
              );
            }).toList() ?? [],
          );
        },
      ),

      floatingActionButton: FloatingActionButton.large(
        elevation: 4,
        foregroundColor: Colors.white,
        onPressed: controller.items.length >= 10
            ? null
            : () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemFormPage(itemController: _itemController, roomItemController: controller,),
          ),
        ),
        child: const Icon(Icons.add_box_outlined),
      ),
    );
  }
}
