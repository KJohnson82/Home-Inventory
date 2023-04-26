import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../firestore_instance.dart';
import '../theme.dart';
import 'ItemsForm.dart';
import '../main.dart';
import 'Rooms.dart';

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
  final String roomName;

  RoomItemsPage({super.key, required this.roomId, required this.roomName});

  @override
  _RoomItemsPageState createState() => _RoomItemsPageState();
}

class _RoomItemsPageState extends State<RoomItemsPage> {
  // final _firestore = FirebaseFirestore.instance;

  // final items = db.collection("items");
  final items = FirestoreInstance.getInstance().collection("items");
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
                height: 40,
                width: 60,
                child: Column(
                  children: [
                    Icon(
                      Icons.add_home_outlined,
                      size: 40,
                      color: homeventory.onSecondary,
                      semanticLabel: "Homes",
                    ),
                    // Text(
                    //   'Homes',
                    //   style:
                    //   TextStyle(color: homeventory.secondary, fontSize: 15),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(75, 0, 5, 0),
              child: SizedBox(
                height: 40,
                width: 60,
                child: Column(
                  children: [
                    Icon(
                      Icons.home_work_outlined,
                      size: 40,
                      color: homeventory.onSecondary,
                      semanticLabel: "Rooms",
                    ),
                    // Text(
                    //   'Rooms',
                    //   style:
                    //   TextStyle(color: homeventory.secondary, fontSize: 15),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: homeventory.primary,
        shadowColor: homeventory.background,
        centerTitle: true,
        title: Text('${widget.roomName}: ITEMS',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            )),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // stream: db
          stream: FirestoreInstance.getInstance()
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
                  color: homeventory.secondary,
                  shadowColor: homeventory.background,
                  surfaceTintColor: homeventory.secondaryContainer,
                  margin: EdgeInsets.fromLTRB(3, 3, 3, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // side: BorderSide(color: Colors.blueGrey),
                  ),
                  elevation: 8,
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.fromLTRB(20, 4, 20, 4),
                    // textColor: Colors.white,
                    // collapsedBackgroundColor: Colors.blue,
                    // collapsedTextColor: Colors.white,
                    // backgroundColor: Colors.white,
                    initiallyExpanded: false,
                    // trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                    title: Text(
                      item['itemName'] ?? 'No Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return AlertDialog(
                            backgroundColor: homeventory.secondary,
                            title: Text(
                                'Edit or Delete ${items[index]["itemName"]}?'),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          child: ItemForm(
                                            roomId: widget.roomId,
                                            item: Item.fromMap(item),
                                            documentId: items[index].id,
                                          ),
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          duration: Duration(milliseconds: 300),
                                        ),
                                      );
                                    },
                                    child: Row(

                                      children: [
                                        const Text('Edit  '),
                                        Icon(Icons.edit),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      String documentId = items[index].id;
                                      // db
                                      FirestoreInstance.getInstance()
                                          .collection('rooms')
                                          .doc(widget.roomId)
                                          .collection('items')
                                          .doc(documentId)
                                          .delete();
                                      _itemNameController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: Row(
                                      children: [
                                        const Text('Delete  '),
                                        Icon(Icons.delete)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
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
              PageTransition(
                  child: ItemForm(roomId: widget.roomId),
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 300)));
        },
        child: const Icon(Icons.list_alt, size: 50),
      ),
    );
  }
}
