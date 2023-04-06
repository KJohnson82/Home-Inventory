import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hvtest1/Homes.dart';
import 'ItemsForm.dart';
import 'RoomItems.dart';

class Room {
  int? roomId;
  String? roomDesc;
  List<Item>? items;

  Room({this.roomId, this.roomDesc, this.items});
}

// final parentHome = ModalRoute.of(context)!.settings.arguments;

class RoomController {
  var highestId = 0;
  var rooms = <Room>[];

  void addRoom(String roomName, String homeName) {

    if (rooms.length < 10) {
      int newId = (highestId + 1);
      rooms.add(Room(roomId: newId, roomDesc: roomName, items: []));
      highestId = newId;
      FirebaseDatabase.instance.ref().child(homeName).push().set({
        'roomId': rooms.last.roomId,
        'roomName': rooms.last.roomDesc,
        'roomItems': rooms.last.items,
      });
    }
  }


}

// void main() => runApp(RoomsPage());

class RoomsPage extends StatefulWidget {
  final String homeName;
  const RoomsPage({Key? key, required this.homeName}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final TextEditingController _roomName = TextEditingController();
  final RoomController controller = RoomController();

  @override
  Widget build(BuildContext context) {
    // final parentHome = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('HOMEVENTORY'),
        centerTitle: true,
      ),
        body: GridView.builder(
            padding: const EdgeInsets.all(100),
            itemCount: controller.rooms.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 40,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RoomItemPage()));
                  print('This was pressed ${_roomName.text}');
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15),
                    shape: BoxShape.rectangle,
                  ),
                  child: Text(controller.rooms[index].roomDesc ?? ''),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton.large(
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
                        setState(() {
                          controller.addRoom(_roomName.text, widget.homeName);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    )
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add_home_work_outlined),
        ),
    );
  }
}
