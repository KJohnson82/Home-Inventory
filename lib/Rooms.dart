// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:hvtest1/Homes.dart';
// import 'package:hvtest1/main.dart';
// import 'ItemsForm.dart';
// import 'RoomItems.dart';
//
// class Room {
//   int? roomId;
//   String? roomDesc;
//   Map<Object, Item>? items;
//
//   Room({this.roomId, this.roomDesc, this.items});
// }
//
// // final parentHome = ModalRoute.of(context)!.settings.arguments;
//
// class RoomController {
//   DatabaseReference roomsRef = FirebaseDatabase.instance.ref('homes').child('rooms');
//   var highestId = 0;
//   var rooms = <Room>[];
//
//   void addRoom(String roomName, String homeName) {
//
//     if (rooms.length < 10) {
//       int newId = (highestId + 1);
//       rooms.add(Room(roomId: newId, roomDesc: roomName, items: {}));
//       highestId = newId;
//       FirebaseDatabase.instance.ref().child('homes').child(homeName).child('rooms').push().set({
//         'roomId': rooms.last.roomId,
//         'roomName': rooms.last.roomDesc,
//         'roomItems': rooms.last.items,
//       });
//       print(rooms.last.roomId);
//       print(rooms.last.roomDesc);
//       print(rooms.last.items);
//     }
//   }
//
//   Future<void> getRooms(String homeName) async {
//     DatabaseReference roomRef = FirebaseDatabase.instance.ref('homes/homeName/rooms');
//     DataSnapshot snapshot = await roomRef.get();
//     if (snapshot.value != null) {
//       Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
//       rooms.clear();
//       for (var key in data.keys) {
//         Map<dynamic, dynamic> roomData = data[key] as Map<dynamic, dynamic>;
//         int roomId = roomData['roomId'];
//         String roomDesc = roomData['roomDesc'];
//         // You can modify this to retrieve items if needed
//         Map<Object, Item>? items = {};
//
//         rooms.add(Room(roomId: roomId, roomDesc: roomDesc, items: items));
//       }
//     }
//   }
// }
//
// // void main() => runApp(RoomsPage());
//
// class RoomsPage extends StatefulWidget {
//   final String homeName;
//   const RoomsPage({Key? key, required this.homeName}) : super(key: key);
//
//   @override
//   _RoomsPageState createState() => _RoomsPageState();
// }
//
// class _RoomsPageState extends State<RoomsPage> {
//   final TextEditingController _roomName = TextEditingController();
//   final RoomController controller = RoomController();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.getRooms(widget.homeName).then((_) {
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final parentHome = ModalRoute.of(context)!.settings.arguments;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HOMEVENTORY'),
//         centerTitle: true,
//       ),
//         body: GridView.builder(
//             padding: const EdgeInsets.all(100),
//             itemCount: controller.rooms.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 30,
//               crossAxisSpacing: 40,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => RoomItemPage()));
//                   print('This was pressed ${_roomName.text}');
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.blueAccent,
//                     borderRadius: BorderRadius.circular(15),
//                     shape: BoxShape.rectangle,
//                   ),
//                   child: Text(controller.rooms[index].roomDesc ?? ''),
//                 ),
//               );
//             }),
//         floatingActionButton: FloatingActionButton.large(
//           elevation: 4,
//           foregroundColor: Colors.white,
//           onPressed: controller.rooms.length >= 10
//               ? null
//               : () {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: const Text('Enter New Room Name: '),
//                   content: TextField(
//                     controller: _roomName,
//                     decoration: const InputDecoration(
//                         hintText: 'Room Name'),
//                   ),
//                   actions: [
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           controller.addRoom(_roomName.text, widget.homeName);
//                         });
//                         Navigator.pop(context);
//                       },
//                       child: const Text('Save'),
//                     )
//                   ],
//                 );
//               },
//             );
//           },
//           child: const Icon(Icons.add_home_work_outlined),
//         ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hvtest1/Homes.dart';
import 'ItemsForm.dart';
import 'RoomItems.dart';
import 'main.dart';

class Room {
  String? roomDesc;
  Map<Object, Item>? items;

  Room({this.roomDesc, this.items});
}

// class RoomController {
//   final rooms = db.collection("rooms");
//   var highestId = 0;
//   var rooms = <Room>[];
//
//   Future<void> addRoom(String roomName, String homeName) async {
//     if (rooms.length < 10) {
//       int newId = (highestId + 1);
//       rooms.add(Room(roomId: newId, roomDesc: roomName, items: {}));
//       highestId = newId;
//
//       await homesRef.doc(homeName).collection('rooms').add({
//         'roomId': rooms.last.roomId,
//         'roomName': rooms.last.roomDesc,
//         // 'roomItems': rooms.last.items, // Firestore doesn't support storing Maps with dynamic keys directly
//       });
//     }
//   }
//
//   Future<void> getRooms(String homeName) async {
//     QuerySnapshot snapshot =
//         await homesRef.doc(homeName).collection('rooms').get();
//     if (snapshot.docs.isNotEmpty) {
//       rooms.clear();
//       for (var doc in snapshot.docs) {
//         Map<String, dynamic> roomData = doc.data() as Map<String, dynamic>;
//         int roomId = roomData['roomId'];
//         String roomDesc = roomData['roomName'];
//         Map<Object, Item>? items = {};
//
//         rooms.add(Room(roomId: roomId, roomDesc: roomDesc, items: items));
//       }
//     }
//   }
// }
//
// class RoomsPage extends StatefulWidget {
//   final String homeName;
//   const RoomsPage({Key? key, required this.homeName}) : super(key: key);
//
//   @override
//   _RoomsPageState createState() => _RoomsPageState();
// }
//
// class _RoomsPageState extends State<RoomsPage> {
//   final TextEditingController _roomName = TextEditingController();
//   final RoomController controller = RoomController();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.getRooms(widget.homeName).then((_) {
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HOMEVENTORY'),
//         centerTitle: true,
//       ),
//       body: GridView.builder(
//           padding: const EdgeInsets.all(100),
//           itemCount: controller.rooms.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 30,
//             crossAxisSpacing: 40,
//           ),
//           itemBuilder: (BuildContext context, int index) {
//             return InkWell(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => RoomItemPage()));
//                 print('This was pressed ${_roomName.text}');
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: Colors.blueAccent,
//                   borderRadius: BorderRadius.circular(15),
//                   shape: BoxShape.rectangle,
//                 ),
//                 child: Text(controller.rooms[index].roomDesc ?? ''),
//               ),
//             );
//           }),
//       floatingActionButton: FloatingActionButton.large(
//         elevation: 4,
//         foregroundColor: Colors.white,
//         onPressed: controller.rooms.length >= 10
//             ? null
//             : () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: const Text('Enter New Room Name: '),
//                       content: TextField(
//                         controller: _roomName,
//                         decoration:
//                             const InputDecoration(hintText: 'Room Name'),
//                       ),
//                       actions: [
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               controller.addRoom(
//                                   _roomName.text, widget.homeName);
//                             });
//                             Navigator.pop(context);
//                           },
//                           child: const Text('Save'),
//                         )
//                       ],
//                     );
//                   },
//                 );
//               },
//         child: const Icon(Icons.add_home_work_outlined),
//       ),
//     );
//   }
// }

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
      // .collection('homes')
      // .doc(widget.homeId)
      // .collection('rooms')
      // .add({
      // 'roomName': _roomNameController.text,
      _roomNameController.clear();
      Navigator.of(context).pop();
    }

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOMEVENTORY: ${widget.homeName}'),
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
            padding: EdgeInsets.all(60),
            itemCount: rooms.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              // return GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             RoomItemsPage(roomId: rooms[index].id),
              //       ),
              //     );
              //   },
              //   child: Card(
              //     child: Center(
              //       child: Text(
              //         rooms[index]['roomName'],
              //         style: const TextStyle(fontSize: 24),
              //       ),
              //     ),
              //   ),
              // );
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoomItemsPage(
                                roomId: rooms[index].id,
                                roomName: rooms[index]['roomName'],
                              )));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(2, 6))
                    ],
                    shape: BoxShape.rectangle,
                  ),
                  child: Text(rooms[index]['roomName']),
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
