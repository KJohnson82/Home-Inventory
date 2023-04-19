import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hvtest1/Routes/Homes.dart';
import 'ItemsForm.dart';
import 'RoomItems.dart';
import '../main.dart';

class Room {
  String? roomDesc;
  Map<Object, Item>? items;

  Room({this.roomDesc, this.items});
}

class RoomsPage extends StatefulWidget {
  final String homeId;
  final String homeName;

  const RoomsPage({super.key, required this.homeId, required this.homeName});

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final _rooms = db.collection("rooms");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _roomNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _addRoom() async {
    if (_formKey.currentState!.validate()) {
      await db.collection('homes').doc(widget.homeId).collection('rooms').add({
        'roomName': _roomNameController.text,
      });
      _roomNameController.clear();
      Navigator.of(context).pop();
    }
  }

  void _editRoom(String documentId, String newName) async {
    if (_formKey.currentState!.validate()) {
      await db
          .collection('homes')
          .doc(widget.homeId)
          .collection('rooms')
          .doc(documentId)
          .update({
        'roomName': newName,
      });
      _roomNameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOMEVENTORY: ${widget.homeName}'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('homes')
            .doc(widget.homeId)
            .collection('rooms')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final rooms = snapshot.data!.docs;

          return GridView.builder(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 60),
            itemCount: rooms.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisSpacing: 20,
              // crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomItemsPage(
                          roomId: rooms[index].id,
                          roomName: rooms[index]['roomName'],
                        ),
                      ));
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return AlertDialog(
                            title: Text(
                                'Edit or Delete ${rooms[index]["roomName"]}?'),
                            content: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _roomNameController,
                                decoration: InputDecoration(
                                    labelText: 'Edit: Room Name'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a new name: ';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Confirm'),
                                onPressed: () {
                                  String documentId = rooms[index].id;
                                  _editRoom(
                                      documentId, _roomNameController.text);
                                  Navigator.of(context).pop();
                                  setState(() {});
                                },
                              ),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  String documentId = rooms[index].id;
                                  db
                                      .collection('homes')
                                      .doc(widget.homeId)
                                      .collection('rooms')
                                      .doc(documentId)
                                      .delete();
                                  _roomNameController.clear();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                      });
                },
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //   // color: appTheme.colorScheme.surface,
                    //   // color: Colors.blue,
                    //   borderRadius: BorderRadius.circular(15),
                    //   boxShadow: const [
                    //     BoxShadow(
                    //         color: Colors.black12,
                    //         spreadRadius: 1,
                    //         blurRadius: 10,
                    //         offset: Offset(2, 6))
                    //   ],
                    //   shape: BoxShape.rectangle,
                    // ),
                    // child: Text(rooms[index]['roomName'],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                    child: Text(
                      rooms[index]['roomName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Enter A Room Name: '),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _roomNameController,
                      decoration: const InputDecoration(labelText: 'Room Name'),
                      focusNode: _focusNode,
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onEditingComplete: () {
                        _addRoom();
                        _roomNameController.clear();
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Add'),
                      onPressed: () {
                        _addRoom();
                        _roomNameController.clear();
                        // Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add_home_work_outlined),
      ),
    );
  }
}
