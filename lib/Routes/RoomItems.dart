import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../firestore_instance.dart';
import '../theme.dart';
import 'Homes.dart';
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
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        icon: const Icon(Icons.add_home_outlined),
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        iconSize: 40,
                        color: homeventory.onSecondary,
                        tooltip: "Homes",
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: HomesPage(),
                                  type: PageTransitionType.leftToRight,
                                  duration: Duration(milliseconds: 300)));
                        },
                      ),
                    ),
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
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          icon: const Icon(Icons.home_work_outlined),
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          iconSize: 40,
                          color: homeventory.onSecondary,
                          tooltip: "Homes",
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         child: Navigator.pop(context),
                            //         type: PageTransitionType.leftToRight,
                            //         duration: Duration(milliseconds: 300)));
                          },
                        ),
                      ),
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
                  borderOnForeground: true,
                  shadowColor: homeventory.onSecondary,
                  surfaceTintColor: homeventory.secondaryContainer,
                  margin: EdgeInsets.fromLTRB(3, 3, 3, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // side: BorderSide(color: Colors.blueGrey),
                  ),
                  elevation: 4,
                  child: ExpansionTile(
                    collapsedTextColor: homeventory.primary,
                    collapsedBackgroundColor: homeventory.secondary,
                    backgroundColor: homeventory.primary,
                    textColor: homeventory.onPrimary,
                    iconColor: homeventory.onPrimary,
                    collapsedIconColor: homeventory.primary,
                    maintainState: true,
                    tilePadding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                    initiallyExpanded: false,
                    childrenPadding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                    title: Text(
                      item['itemName'] ?? 'No Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ListTile(
                        title: Text('Type: ${item['itemType'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: homeventory.onSecondary, fontSize: 15,)),
                        dense: false,
                      ),
                      ListTile(
                        title: Text('Subtype: ${item['itemSubtype'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: homeventory.onSecondary)),
                        dense: false,
                      ),
                      ListTile(
                        title: Text('Brand: ${item['itemBrand'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: homeventory.onSecondary)),
                        dense: false,
                      ),
                      ListTile(
                        title: Text('Model: ${item['itemModel'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: homeventory.onSecondary)),
                        dense: false,
                      ),
                      ListTile(
                        title: Text(
                            'Dimensions: ${item['itemDimensions'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: homeventory.onSecondary)),
                        dense: false,
                      ),
                      ListTile(
                        title: Text('Color: ${item['itemColor'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: homeventory.onSecondary)),
                        dense: false,
                      ),
                      ListTile(
                        title: Text('Notes: ${item['itemNotes'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: homeventory.onSecondary)),
                        dense: false,
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
