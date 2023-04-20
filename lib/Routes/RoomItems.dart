import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import 'ItemsForm.dart';
import '../main.dart';

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

class RoomItemsPage extends StatefulWidget {
  final String roomId;

  RoomItemsPage({super.key, required this.roomId, required roomName});

  @override
  _RoomItemsPageState createState() => _RoomItemsPageState();
}

class _RoomItemsPageState extends State<RoomItemsPage> {
  // final _firestore = FirebaseFirestore.instance;
  final items = db.collection("items");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
        color: homeventory.primary,
        surfaceTintColor: homeventory.primary,
        elevation: 3,
        notchMargin: 8,
        shape: const AutomaticNotchedShape(
          ContinuousRectangleBorder(
            // borderRadius: BorderRadius.all(
            //   Radius.circular(1),
            // )),
          ),
          StadiumBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Icon(Icons.home_filled, size: 40,),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 75, 0),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Column(
                  children: [
                    Icon(
                      Icons.add_home,
                      size: 40,
                      color: homeventory.secondary,
                      semanticLabel: "Homes",
                    ),
                    Text(
                      'Homes',
                      style:
                      TextStyle(color: homeventory.secondary, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(75, 0, 5, 0),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Column(
                  children: [
                    Icon(
                      Icons.home_work,
                      size: 40,
                      color: homeventory.secondary,
                      semanticLabel: "Rooms",
                    ),
                    Text(
                      'Rooms',
                      style:
                      TextStyle(color: homeventory.secondary, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Room Items'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db
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
              return GestureDetector(
                child: Card(
                  // color: Colors.blue,
                  margin: EdgeInsets.fromLTRB(3, 3, 3, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      // side: BorderSide(color: Colors.blueGrey),
                  ),
                  elevation: 3,
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.fromLTRB(20, 4, 20, 4),
                    // textColor: Colors.white,
                    // collapsedBackgroundColor: Colors.blue,
                    // collapsedTextColor: Colors.white,
                    // backgroundColor: Colors.white,
                    initiallyExpanded: false,
                    // trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                    title: Text(item['itemName'] ?? 'No Name', style: TextStyle(fontWeight: FontWeight.bold),),
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
                        title: Text(
                            'Dimensions: ${item['itemDimensions'] ?? 'N/A'}'),
                      ),
                      ListTile(
                        title: Text('Color: ${item['itemColor'] ?? 'N/A'}'),
                      ),
                      ListTile(
                        title: Text('Notes: ${item['itemNotes'] ?? 'N/A'}'),
                      ),
                    ],
                  ),
                ),
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete ${items[index]["itemName"]}?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Confirm'),
                              onPressed: () {
                                String documentId = items[index].id;
                                db
                                    .collection('rooms')
                                    .doc(widget.roomId)
                                    .collection('items')
                                    .doc(documentId)
                                    .delete();
                                _itemNameController.clear();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.large(
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

// deleteItem(item) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Delete ${items[index]["itemName"]}?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Confirm'),
//               onPressed: () {
//                 String documentId = item[index].id;
//                 db
//                     .collection('rooms')
//                     .doc(widget.roomId)
//                     .collection('items')
//                     .doc(documentId)
//                     .delete();
//                 _itemNameController.clear();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       });
// }
