// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'ItemsForm.dart';
// import 'Rooms.dart';
// import 'main.dart';
// import 'Homes.dart';
//
// class RoomItem {
//   int? itemId;
//   String? itemDesc; //Item Name
//   List<Item>? items;
//
//   RoomItem({
//     required this.itemId,
//     required this.itemDesc, //Item Name
//     this.items,
//   });
// }
//
// class RoomItemController {
//   List<RoomItem> items = [];
//   int highestId = 0;
//
// //   void addRoomItem(String itemName) {
// //     if (items.length < 50) {
// //       int newId = (highestId + 1);
// //       items.add(RoomItem(
// //         itemId: newId,
// //         itemDesc: itemName,
// //         items: [],
// //       ));
// //       highestId = newId;
// //       FirebaseDatabase.instance.ref().child('items').push().set({
// //         'itemId': items[newId].itemId,
// //         'itemName': items[newId].itemDesc,
// //         'items': items[newId].items,
// //       });
// //     }
// //   }
// }
//
// class RoomItemPage extends StatefulWidget {
//   const RoomItemPage({Key? key}) : super(key: key);
//
//   @override
//   _RoomItemPageState createState() => _RoomItemPageState();
// }
//
// class _RoomItemPageState extends State<RoomItemPage> {
//   final RoomItemController controller = RoomItemController();
//   final ItemController _itemController = ItemController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HOMEVENTORY'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: controller.items.length,
//         itemBuilder: (context, index) {
//           RoomItem roomItem = controller.items[index];
//           return ExpansionTile(
//             title: Text(roomItem.itemDesc ?? ''),
//             children: roomItem.items?.map((item) {
//               return Column(
//                 children: [
//                   ListTile(
//                     title: Text('Type: ${item.itemType ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Subtype: ${item.itemSubtype ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Brand: ${item.itemBrand ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Model: ${item.itemModel ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Dimensions: ${item.itemDimensions ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Color: ${item.itemColor ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Notes: ${item.itemNotes ?? ''}'),
//                   ),
//                 ],
//               );
//             }).toList() ?? [],
//           );
//         },
//       ),
//
//       floatingActionButton: FloatingActionButton.large(
//         elevation: 4,
//         foregroundColor: Colors.white,
//         onPressed: controller.items.length >= 10
//             ? null
//             : () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ItemFormPage(itemController: _itemController, roomItemController: controller,),
//           ),
//         ),
//         child: const Icon(Icons.add_box_outlined),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ItemsForm.dart';
import 'main.dart';

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

// class RoomItemController {
//   final items = db.collection("items");
//   // List<RoomItem> items = [];
//   int highestId = 0;
// }
//
// class RoomItemPage extends StatefulWidget {
//   const RoomItemPage({Key? key}) : super(key: key);
//
//   @override
//   _RoomItemPageState createState() => _RoomItemPageState();
// }
//
// class _RoomItemPageState extends State<RoomItemPage> {
//   final RoomItemController controller = RoomItemController();
//   final ItemController _itemController = ItemController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HOMEVENTORY'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: controller.items.length,
//         itemBuilder: (context, index) {
//           RoomItem roomItem = controller.items[index];
//           return ExpansionTile(
//             title: Text(roomItem.itemDesc ?? ''),
//             children: roomItem.items?.map((item) {
//               return Column(
//                 children: [
//                   ListTile(
//                     title: Text('Type: ${item.itemType ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Subtype: ${item.itemSubtype ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Brand: ${item.itemBrand ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Model: ${item.itemModel ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Dimensions: ${item.itemDimensions ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Color: ${item.itemColor ?? ''}'),
//                   ),
//                   ListTile(
//                     title: Text('Notes: ${item.itemNotes ?? ''}'),
//                   ),
//                 ],
//               );
//             }).toList() ?? [],
//           );
//         },
//       ),
//
//       floatingActionButton: FloatingActionButton.large(
//         elevation: 4,
//         foregroundColor: Colors.white,
//         onPressed: controller.items.length >= 10
//             ? null
//             : () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ItemFormPage(itemController: _itemController, roomItemController: controller,),
//           ),
//         ),
//         child: const Icon(Icons.add_box_outlined),
//       ),
//     );
//   }
// }



class RoomItemsPage extends StatefulWidget {
  final String roomId;

  RoomItemsPage({super.key, required this.roomId, required roomName});

  @override
  _RoomItemsPageState createState() => _RoomItemsPageState();
}

class _RoomItemsPageState extends State<RoomItemsPage> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Items'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('rooms')
            .doc(widget.roomId)
            .collection('items')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!.docs;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index].data() as Map<String, dynamic>;
              return ExpansionTile(
                title: Text(item['itemName'] ?? 'No Name'),
                children: [
                  ListTile(
                    title: Text('Type: ${item['itemType'] ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Subtype: ${item['itemSubtype'] ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Brand: ${item['itemBrand'] ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Model: ${item['itemModel'] ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Dimensions: ${item['itemDimensions'] ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Color: ${item['itemColor'] ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Notes: ${item['itemNotes'] ?? 'N/A'}'),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemForm(roomId: widget.roomId),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
